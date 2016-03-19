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
    File.absolute_path("../mrblib/mspec/utils/version.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/version.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/utils/options.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/const_lookup.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/utils/name_map.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/commands/mkspec.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/context.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/exception.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/tag.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/mspec.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/tally.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/guard.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/expectations/expectations.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/timer.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/dotted.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/utils/script.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/commands/mspec-ci.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/commands/mspec-run.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/commands/mspec-tag.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/tmp.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/filters/match.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/filter.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/commands/mspec.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/expectations/should.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/expectations.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/background.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/block_device.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/version.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/bug.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/compliance.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/conflict.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/endian.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/extensions.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/feature.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/noncompliance.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/platform.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/quarantine.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/runner.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/specified.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/superuser.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/support.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/tty.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards/user.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/utils/ruby_name.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/guards.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/argf.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/argv.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/datetime.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/ducktype.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/encode.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/enumerator_class.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/environment.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/fixture.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/flunk.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/fs.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/hash.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/io.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/mock_to_path.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/numeric.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/pack.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/ruby_exe.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/scratch.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/singleton_class.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers/stasy.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/helpers.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/base.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_an_instance_of.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_ancestor_of.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_close.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_computed_by.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_computed_by_function.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_empty.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_false.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_kind_of.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_nan.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_nil.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_true.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_true_or_false.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/be_valid_dns_name.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/complain.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/eql.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/equal.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/equal_element.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/equal_utf16.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/stringsymboladapter.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/variable.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_class_variable.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_constant.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_data.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_instance_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_instance_variable.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_private_instance_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_private_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_protected_instance_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_public_instance_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/have_singleton_method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/include.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/infinity.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/match_yaml.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/output.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/output_to_fd.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/raise_error.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/respond_to.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers/signed_zero.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/matchers.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/mocks/mock.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/mocks/proxy.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/mocks/object.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/mocks.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/leakchecker.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/tag.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/taglist.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions/tagpurge.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/actions.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/evaluate.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/example.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/filters/profile.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/filters/regexp.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/filters/tag.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/filters.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/describe.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/file.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/html.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/yaml.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/junit.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/method.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/profile.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/specdoc.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/spinner.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/summary.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters/unit.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/formatters.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/object.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner/shared.rb", __FILE__),
    File.absolute_path("../mrblib/mspec/runner.rb", __FILE__),
    File.absolute_path("../mrblib/mspec.rb", __FILE__),
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