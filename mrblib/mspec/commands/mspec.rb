#!/usr/bin/env ruby

MSPEC_HOME = File.expand_path(File.dirname(__FILE__) + '/../../..')

require 'mspec/version'
require 'mspec/utils/options'
require 'mspec/utils/script'
require 'mspec/helpers/tmp'
require 'mspec/runner/actions/filter'
require 'mspec/runner/actions/timer'


class MSpecMain < MSpecScript
  def initialize
    config[:includes] = []
    config[:requires] = []
    config[:target]   = ENV['RUBY'] || 'ruby'
    config[:flags]    = []
    config[:command]  = nil
    config[:options]  = []
    config[:launch]   = []
  end

  def options(argv=ARGV)
    config[:command] = argv.shift if ["ci", "run", "tag"].include?(argv[0])

    options = MSpecOptions.new "mspec [COMMAND] [options] (FILE|DIRECTORY|GLOB)+", 30, config

    options.doc " The mspec command sets up and invokes the sub-commands"
    options.doc " (see below) to enable, for instance, running the specs"
    options.doc " with different implementations like ruby, jruby, rbx, etc.\n"

    options.configure do |f|
      load f
      config[:options] << '-B' << f
    end

    options.targets

    options.on("-A", "--valgrind", "Run under valgrind") do
      config[:use_valgrind] = true
    end

    options.on("--warnings", "Don't supress warnings") do
      config[:flags] << '-w'
      ENV['OUTPUT_WARNINGS'] = '1'
    end

    options.on("-j", "--multi", "Run multiple (possibly parallel) subprocesses") do
      config[:multi] = true
      config[:options] << "-fy"
    end

    options.version MSpec::VERSION do
      if config[:command]
        config[:options] << "-v"
      else
        puts "#{File.basename $0} #{MSpec::VERSION}"
        exit
      end
    end

    options.help do
      if config[:command]
        config[:options] << "-h"
      else
        puts options
        exit 1
      end
    end

    options.doc "\n Custom options"
    custom_options options

    # The rest of the help output
    options.doc "\n where COMMAND is one of:\n"
    options.doc "   run - Run the specified specs (default)"
    options.doc "   ci  - Run the known good specs"
    options.doc "   tag - Add or remove tags\n"
    options.doc " mspec COMMAND -h for more options\n"
    options.doc "   example: $ mspec run -h\n"

    options.on_extra { |o| config[:options] << o }
    config[:options].concat options.parse(argv)
  end

  def register; end

  def parallel
    @parallel ||= !(Object.const_defined?(:JRUBY_VERSION) ||
                  /(mswin|mingw)/ =~ RUBY_PLATFORM)
  end

  def fork(&block)
    parallel ? Kernel.fork(&block) : block.call
  end

  def report(files, timer)
    require 'yaml'

    exceptions = []
    tally = Tally.new

    files.each do |file|
      d = File.open(file, "r") { |f| YAML.load f }
      File.delete file

      exceptions += Array(d['exceptions'])
      tally.files!        d['files']
      tally.examples!     d['examples']
      tally.expectations! d['expectations']
      tally.errors!       d['errors']
      tally.failures!     d['failures']
    end

    print "\n"
    exceptions.each_with_index do |exc, index|
      print "\n#{index+1})\n", exc, "\n"
    end
    print "\n#{timer.format}\n\n#{tally.format}\n"
  end

  def multi_exec(argv)
    timer = TimerAction.new
    timer.start

    pids = []
    files = config[:ci_files].inject([]) do |list, item|
      name = tmp "mspec-ci-multi-#{list.size}"

      rest = argv + ["-o", name, item]
      if Kernel.respond_to?(:fork)
        pid = fork { system [config[:target], *rest].join(" ") }
        pids.push(pid) if pid
      elsif Kernel.respond_to?(:spawn)
        pids.push spawn([config[:target], *rest].join(" "))
      end

      list << name
    end

    if Process.respond_to?(:waitall)
      Process.waitall
    else
      pids.each { |p| Process.wait(p) }
    end
    timer.finish
    report files, timer
  end
  
  def try_exec(*argv)
    if Kernel.respond_to?(:exec)
      exec *argv
    elsif Kernel.respond_to?(:spawn) && Process.repond_to?(:wait)
      pid = spawn *argv
      Process.wait(pid)
      exit $?.exitstatus
    else
      if system(argv.join(' '))
        exit 0
      else
        exit 1
      end
    end
  end

  def run
    ENV['MSPEC_RUNNER'] = '1'
    ENV['RUBY_EXE']     = config[:target]
    ENV['RUBY_FLAGS']   = config[:flags].join " "

    argv = []

    argv.concat config[:launch]
    argv.concat config[:flags]
    argv.concat config[:includes]
    argv.concat config[:requires]
    argv << "-v"
    argv << "#{MSPEC_HOME}/bin/mspec-#{ config[:command] || "run" }"
    argv.concat config[:options]

    if config[:multi] and config[:command] == "ci"
      multi_exec argv
    else
      if config[:use_valgrind]
        more = ["--child-silent-after-fork=yes",
                config[:target]] + argv
        try_exec "valgrind", *more
      else
        cmd, *rest = config[:target].split(/\s+/)
        argv = rest + argv unless rest.empty?
        try_exec cmd, *argv
      end
    end
  end
end
