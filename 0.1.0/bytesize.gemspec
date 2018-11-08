
#!/usr/bin/env ruby -w
# -*- encoding: utf-8 -*-
#
# ByteSize
#
# bytesize.gemspec
#
# © 2018 Adam Hunt
# Created: 2018-03-24
# Modified: 2018-03-24
#



require_relative 'lib/bytesize/version'



Gem::Specification.new do |gem|
	gem.name          = 'bytesize'
	gem.version       = ByteSize::VERSION
	gem.summary       = 'A simple Ruby object that stores a size in bytes, while providing human-readible string output'
	gem.description   = 'ByteSize is a simple Ruby object that stores a size in bytes, while providing human-readible string output with apropriate SI or IEC suffixes. Ample convenience methods are also supplied for quick shorthand.'
	gem.has_rdoc      = false
	gem.author        = 'Adam Hunt'
	gem.email         = 'bytesize@adamhunt.name'
	gem.homepage      = 'http://github.com/ajmihunt/bytesize'
	gem.license       = 'MIT'

	gem.executables   = Dir.glob('bin/*').collect{|f| File.basename(f) }
	gem.files         = Dir.glob('lib/**/*.rb')
	                    .push( *Dir.glob('*.{txt,md}') )
	gem.test_files    = Dir.glob('{test,spec,features}/**/*')
	gem.require_paths = ['lib']

	gem.required_ruby_version = '>= 2.1.0'

	gem.add_development_dependency "bundler", "~> 1.16"
	gem.add_development_dependency "rake",    "~> 10.0"
	gem.add_development_dependency "rspec",   "~> 3.0"
end


