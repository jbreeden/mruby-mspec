# mruby-mspec

MSpec test framework as an MRuby Gem.

## Dependencies

Currently depends on [mruby-apr](https://github.com/jbreeden/mruby-apr).

Obstacles to removing this dependency:
- mruby-apr currently provides some `RbConfig` values and other globals
  + These could easily be moved into this gem.
- mruby-apr has `File`, `Dir`, and other api's used by MSpec when loading/executing tests.
  + These could be implemented in this gem, but the extent of that work is not yet known.

## Building

Add `mruby-apr` & `mruby-spec` to your `build_config.rb` file. You will also need to build libapr.
See [mruby-apr](https://github.com/jbreeden/mruby-apr) for instructions.

### Example

```Ruby
# mruby/build_config.rb

MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  conf.enable_debug

  conf.cc.flags << '-DMRB_INT64'

  conf.gembox 'full-core'
  conf.gem github: 'jbreeden/mruby-apr'
  conf.gem github: 'jbreeden/mruby-mspec'
end
```

## Running Tests

No binary is provided yet, but you can use the `-e` option of mruby to invoke the main method.

```Ruby
mruby -e MSpecRun.main your_test_file.rb
```

Or, if you prefer, use an alias.

```Bash
alias mrbspec="mruby -e MSpecRun.main"
mrbspec your_test_file.rb
```

## Limitations

These should be fixed sooner than later, but for now...

- No way to pass flags to mspec
  + This means you're stuck with the default formatter, for examle.
  + The `mruby` executable tries to read all flags provided in the command line.
  + Could submit a PR to mruby for this (as it would be nice to have) or make a separate mruby-bin-mspec (which is tiresome).
