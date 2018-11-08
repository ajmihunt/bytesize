#!/usr/bin/env ruby -w
#
# ByteSize
#
# Unit-based Numeric convenience methods
#
# © 2018 Adam Hunt
# Created: 2018-01-18
# Modified: 2018-04-08
#



require 'bytesize'



# Requiring <code>bytesize/units</code> adds convenience methods to
# {Numeric}[https://ruby-doc.org/stdlib/libdoc/pathname/rdoc/Numeric.html]
# for easy creation of {ByteSize}[ByteSize.html] and {IECByteSize}[IECByteSize.html] values.
#
#
# === Examples of use
#
#   require 'bytesize/units'
#
#   1.21.gib       #=> (1.21 GiB)
#
#   3.tb           #=> (3 TB)
#
#   100.gb         #=> (100 GB)
#
#   42.gib.to_mib  #=> 43008.0
#   
#   22.gib.to_si   #=> (23.62 GB)
#   
#   16.gb.to_iec   #=> (14.9 GiB)
#
class Numeric
	
	
	
	# :stopdoc:
	ByteSize::SI_ORDERS_OF_MAGNITUDE.keys.each do |k|
		m = k.downcase
		define_method(m) do
			ByteSize.send( m, self )
		end
	end
	
	IECByteSize::UNIT_SYMBOLS.keys.reject{|k| k == :bytes }.each do |k|
		m = k.downcase
		define_method(m) do
			IECByteSize.send( m, self )
		end
	end
	# :startdoc:
	
	
	
	##
	# :call-seq:
	#   bytes  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of bytes.
	#
	# :method: bytes
	
	
	
	##
	# :call-seq:
	#   kb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of kilobytes.
	#
	# :method: kb
	
	
	
	##
	# :call-seq:
	#   mb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of megabytes.
	#
	# :method: mb
	
	
	
	##
	# :call-seq:
	#   gb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of gigabytes.
	#
	# :method: gb
	
	
	
	##
	# :call-seq:
	#   tb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of terabytes.
	#
	# :method: tb
	
	
	
	##
	# :call-seq:
	#   pb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of petabytes.
	#
	# :method: pb
	
	
	
	##
	# :call-seq:
	#   eb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of exabytes.
	#
	# :method: eb
	
	
	
	##
	# :call-seq:
	#   zb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of zettabytes.
	#
	# :method: zb
	
	
	
	##
	# :call-seq:
	#   yb  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>self</em> number of yottabytes.
	#
	# :method: yb
	
	
	
	##
	# :call-seq:
	#   kib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of kibibytes.
	#
	# :method: kib
	
	
	
	##
	# :call-seq:
	#   mib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of mebibytes.
	#
	# :method: mib
	
	
	
	##
	# :call-seq:
	#   gib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of gibibytes.
	#
	# :method: gib
	
	
	
	##
	# :call-seq:
	#   tib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of tebibytes.
	#
	# :method: tib
	
	
	
	##
	# :call-seq:
	#   pib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of pebibytes.
	#
	# :method: pib
	
	
	
	##
	# :call-seq:
	#   eib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of exbibytes.
	#
	# :method: eib
	
	
	
	##
	# :call-seq:
	#   zib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of zebibytes.
	#
	# :method: zib
	
	
	
	##
	# :call-seq:
	#   yib  ->  bytesize
	#
	# Returns a new instance of {IECByteSize}[IECByteSize.html] representing <em>self</em> number of yobibytes.
	#
	# :method: yib
	
	
	
end