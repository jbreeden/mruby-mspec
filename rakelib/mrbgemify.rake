require 'json'

desc 'Generate mrbgem files'
task :'mrbgemify' => ['mrbgemify:dependencies', 'mrbgemify:generate', 'mrbgemify:cleanup']

if File.exists?('mrbgemify.conf.rb')
  load 'mrbgemify.conf.rb'
end

module MRBGemify
  unless self.const_defined?(:MRBGEM_TEMPLATE)
    MRBGEM_TEMPLATE = <<-EOS
# This file was generated by the mrbgemify rake task
# You may provide additional configuration in an mrbgem.ext.rake file.
# Alternatively, you can edit the template for this file in mrbgemify.conf.rb

MRuby::Gem::Specification.new('mruby-mspec') do |spec|
  spec.author = 'Jared Breeden'
  spec.summary = 'MSpec as an mrbgem'
  spec.license = 'MIT'

  spec.add_dependency 'mruby-apr'

  spec.rbfiles = [
    File.absolute_path("../mrblib/require_patch.rb", __FILE__),
<% required_files.each do |file| -%>
    File.absolute_path(<%= JSON.dump(file).sub(File.absolute_path('.'), '..') %>, __FILE__),
<% end -%>
    File.absolute_path("../mrblib/require_restore.rb", __FILE__),
    File.absolute_path("../mrblib/builtin_features.rb", __FILE__)
  ]

  mrbgem_ext_rake = File.absolute_path('../mrbgem.ext.rake', __FILE__)
  if File.exists?(mrbgem_ext_rake)
    require 'stringio'
    io = StringIO.new
    io.print "proc { |spec|; "
    io.puts File.read(mrbgem_ext_rake)
    io.puts "}"
    p = eval(io.string)
    p[spec]
  end
end
EOS
  end
  
  unless self.const_defined?(:REQUIRED_FILES)
    REQUIRED_FILES = ['./mrblib/*/**/*.rb']
  end
end

unless File.exists?('mrbgemify.conf.rb')
  File.open('mrbgemify.conf.rb', 'w') do |f|
    f.puts 'module MRBGemify'
    f.puts ('  REQUIRED_FILES = ' + JSON.dump(MRBGemify::REQUIRED_FILES))
    f.puts
    f.puts '  MRBGEM_TEMPLATE = <<-END_OF_MRBGEM_TEMPLATE.strip'
    f.puts MRBGemify::MRBGEM_TEMPLATE
    f.puts '  END_OF_MRBGEM_TEMPLATE'
    f.puts 'end'
  end
end

namespace :mrbgemify do
  task :dependencies do
    require 'pathname'
    require 'pp'
    require 'json'

    main = self

    $requires_data = []

    module Kernel
      alias requires_load load
      alias requires_require require
      alias requires_require_relative require_relative
        
      def requires_restore
        Kernel.send(:alias_method, :load, :requires_load)
        Kernel.send(:alias_method, :require, :requires_require)
        Kernel.send(:alias_method, :require_relative, :requires_require_relative)
      end
      
      # Kinda-sorta (fuzzy) require path resolution
      def requires_lookup(path)
        caller_dir = File.dirname(caller[0][/(^.*):[0-9]/, 1])
        result = []
        (['.'] + $:).inject(result) do |result, p|
          result.concat(
            Dir["#{p}/#{path}"] +
            Dir["#{p}/#{path}.rb"] +
            Dir["#{p}/#{caller_dir}/#{path}"] +
            Dir["#{p}/#{caller_dir}/#{path}.rb"]
          )
        end
        result.concat Dir["#{path}"]
        result.select { |f| File.file?(f) }.map { |f| File.absolute_path(f) }.uniq
      end
      
      def load(*args)
        loaded = requires_load(*args)
        file = args[0]
        paths = requires_lookup(args[0])
        if paths.empty?
          internal = false
        else
          internal = Pathname.new(paths[0]).enum_for(:descend).any? { |root| Dir.pwd == root.to_s }
        end
        $requires_data.push({
          :type => :load,
          :file => file,
          :paths => paths,
          :from => caller[0][/(^.*):[0-9]/, 1],
          :internal => internal
        })
        loaded
      end
      
      def require(*args)
        loaded = requires_require(*args)
        if loaded
          file = args[0]
          paths = requires_lookup(args[0])
          if paths.empty?
            internal = false
          else
            internal = Pathname.new(paths[0]).enum_for(:descend).any? { |root| 
              Dir.pwd == root.to_s
            }
          end
          $requires_data.push({
            :type => :require,
            :file => file,
            :paths => paths,
            :from => caller[0][/(^.*):[0-9]/, 1],
            :internal => internal
          })
        end
        loaded
      end
      
      def require_relative(*args)
        path = "#{File.dirname(caller[0][/(^.*):[0-9]/, 1])}/#{args[0]}"
        loaded = requires_require path
        if loaded
          paths = [path, "#{path}.rb"].select { |f| File.file?(f) }
          if paths.empty?
            internal = false
          else
            internal = Pathname.new(paths[0]).enum_for(:descend).any? { |root| Dir.pwd == root.to_s }
          end
          $requires_data.push({
            :type => :require_relative,
            :file => args[0],
            :paths => paths,
            :from => caller[0][/(^.*):[0-9]/, 1],
            :internal => internal
          })
        end
        loaded
      end
    end

    $: << File.absolute_path('./mrblib')

    Dir.glob(MRBGemify::REQUIRED_FILES).uniq.each do |f|
      require f.sub('./mrblib/', '').sub('.rb', '')
    end

    File.open('.mrbgemify.dependencies.json', 'w') { |f| f.puts JSON.pretty_generate($requires_data) }
  end

  task :generate do
    require 'pathname'
    require 'json'
    require 'erb'

    requires = JSON.parse(File.read('.mrbgemify.dependencies.json')).select { |f| f['internal'] }
    required_files = requires.map { |r| r['paths'][0] }
    template = ERB.new(MRBGemify::MRBGEM_TEMPLATE, nil, '-')
    File.open('mrbgem.rake', 'w') { |f| f.write template.result(binding) }

    File.open("./mrblib/builtin_features.rb", 'w') do |f|
      f.write <<-EOS
$BUILTIN_FEATURES.concat([
  #{requires.map { |r| JSON.dump(r['file']) }.join(",\n  ")}
])
EOS
    end
  end
  
  task :cleanup do
    rm '.mrbgemify.dependencies.json'
  end
end
