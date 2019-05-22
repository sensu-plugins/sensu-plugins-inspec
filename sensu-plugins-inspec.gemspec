lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require_relative 'lib/sensu-plugins-inspec'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |s|
  s.authors                = ['Sensu-Plugins and contributors']

  s.date                   = Date.today.to_s
  s.description            = 'Sensu InSpec'
  s.email                  = '<sensu-users@googlegroups.com>'
  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w[LICENSE README.md CHANGELOG.md]
  s.homepage               = 'https://github.com/sensu-plugins/sensu-plugins-inspec'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => 'sensu-plugin',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-inspec'
  s.platform               = Gem::Platform::RUBY
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 2.4.0'

  s.summary                = 'Sensu plugin for executing InSpec controls'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsInspec::Version::VER_STRING

  s.add_runtime_dependency 'sensu-plugin', '~> 1.2'
  s.add_runtime_dependency 'inspec', '>= 1.47', '< 5.0'

  s.add_development_dependency 'bundler',                   '~> 1.7'
  s.add_development_dependency 'github-markup',             '~> 3.0'
  s.add_development_dependency 'pry',                       '~> 0.10'
  s.add_development_dependency 'rubocop',                   '~> 0.49.0'
  s.add_development_dependency 'rspec',                     '~> 3.1'
  s.add_development_dependency 'rake',                      '~> 12.3'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'yard',                      '>= 0.9.11', '< 1.0'
end
