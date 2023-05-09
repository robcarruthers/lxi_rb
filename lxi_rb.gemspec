# frozen_string_literal: true

require_relative 'lib/lxi/version'

Gem::Specification.new do |spec|
  spec.name = 'lxi_rb'
  spec.version = Lxi::VERSION
  spec.authors = ['Rob Carruthers']
  spec.email = ['robcarruthers@mac.com']

  spec.summary = 'Ruby wrapper for the liblxi library.'
  spec.description = 'The gem includes methods required for discovering and communicating with LXI compliant devices'
  spec.homepage = 'https://github.com/robcarruthers/lxi_rb'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/robcarruthers/lxi_rb'
  spec.metadata['changelog_uri'] = 'https://github.com/robcarruthers/lxi_rb/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(__dir__) do
      `git ls-files -z`.split("\x0")
        .reject do |f|
          (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
        end
    end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency 'ffi', '~> 1.15'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
