#!/usr/bin/env ruby -w
#
# ByteSize
#
# ActiveRecord Type
#
# © 2018 Adam Hunt
# Created: 2018-01-24
# Modified: 2018-01-24
#



require 'bytesize'



class ByteSize
	class ActiveRecordType < ActiveRecord::Type::Value
		
		def cast( value )
			value.nil? ? nil : ByteSize.new(value)
		end
		
		def deserialize( value )
			value.nil? ? nil : ByteSize.new(value)
		end
		
		def serialize( value )
			value.nil? ? nil : value.to_i
		end
		
	end
end

ActiveRecord::Type.register( :bytesize, ByteSize::ActiveRecordType )

module ActiveRecord
	module ConnectionAdapters
		module MySQL
			module ColumnMethods
				
				def bytesize( *args, **options )
					args.each{|name| column( name, :bigint, options.merge(unsigned:true) )}
				end
				
			end
		end
	end
end