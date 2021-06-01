
#!/usr/bin/env ruby -w
# -*- encoding: utf-8 -*-
#
# ByteSize
#
# bytesize.gemspec
#
# © 2018-2021 Adam Hunt
# Created: 2018-03-24
# Modified: 2021-06-01
#



require 'pathname'
require 'fileutils'



gem_root = Pathname.new(__dir__).expand_path
lib = (gem_root + 'lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib.to_s)

require_relative 'lib/bytesize/version'



Gem::Specification.new do |gem|
	gem.name          = 'bytesize'
	gem.version       = ByteSize::VERSION
	gem.summary       = 'A simple Ruby object that stores a size in bytes, while providing human-readible string output.'
	gem.description   = 'ByteSize is a simple Ruby object that stores a size in bytes, while providing human-readible string output with apropriate SI or IEC suffixes. Ample convenience methods are also supplied for quick shorthand.'
	gem.author        = 'Adam Hunt'
	gem.email         = 'bytesize@adamhunt.com'
	gem.homepage      = 'http://github.com/ajmihunt/bytesize'
	gem.license       = 'MIT'
	
	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	gem.files = Dir.chdir(gem_root) do
		`git ls-files -z`.split("\x0").reject{|f| f.match(%r{^(test|spec|features)/}) }
	end

	gem.executables   = []
	gem.require_paths = ['lib']
	gem.test_files    = Dir.glob('{test,spec,features}/**/*')

	gem.required_ruby_version = '>= 2.1.0'

	gem.add_development_dependency 'bundler', '>= 2.2.10'
	gem.add_development_dependency 'rake',    '>= 12.3.3'
	gem.add_development_dependency 'rspec',   '>= 3.10.0'
end


