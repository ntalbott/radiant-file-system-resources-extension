# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'radiant-file_system_resources-extension'

Gem::Specification.new do |s|
  s.name        = "radiant-file_system_resources-extension"
  s.version     = RadiantFileSystemResourcesExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Nathaniel Talbott', 'Jim Gay', 'John Muhl']
  s.email       = 'nathaniel@talbott.ws'
  s.homepage    = RadiantFileSystemResourcesExtension::URL
  s.summary     = RadiantFileSystemResourcesExtension::SUMMARY
  s.description = RadiantFileSystemResourcesExtension::DESCRIPTION

  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end

  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  s.require_paths = ["lib"]
end
