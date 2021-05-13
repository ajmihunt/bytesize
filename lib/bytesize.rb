#!/usr/bin/env ruby -w
#
# ByteSize
#
# bytesize.rb
#
# © 2018 Adam Hunt
# Created: 2018-01-17
# Modified: 2018-04-09
#



##
# :title: ByteSize Documentation
#
# :include: ../README.md
#



require 'bytesize/version'

require 'pathname'



# This class is used to represent a size in bytes.
#
# It uses the {SI}[https://en.wikipedia.org/wiki/International_System_of_Units] standard unit symbols: kB, MB, GB, TB, PB, EB, ZB, YB.
#
# For a version that uses the {IEC}[https://en.wikipedia.org/wiki/ISO/IEC_80000] standard unit symbols, see <i>{IECByteSize}[IECByteSize.html]</i>.
#
# === Examples of use
#
#   ByteSize.new( 4127 )	  #=> (4.13 kB)
#   ByteSize.new( "22 GB" )   #=> (22 GB)
#   ByteSize.new( "22 GiB" )  #=> (23.62 GB)
#
#   ByteSize.bytes( 42 )	  #=> (42 bytes)
#
#   ByteSize.kb( 42 )		 #=> (42 kB)
#   ByteSize.mb( 42 )		 #=> (42 MB)
#   ByteSize.gb( 42 )		 #=> (42 GB)
#   ByteSize.tb( 42 )		 #=> (42 TB)
#   ByteSize.pb( 42 )		 #=> (42 PB)
#   ByteSize.eb( 42 )		 #=> (42 EB)
#   ByteSize.zb( 42 )		 #=> (42 ZB)
#   ByteSize.yb( 42 )		 #=> (42 YB)
#
# === Conversion of values:
#
#   ByteSize.gb( 100 ).to_gib	#=> 93.13225746154785
#
#   ByteSize.gib( 2.42 ).to_mib  #=> 2478.079999923706
#
# === With numeric convenience methods:
#
#   require 'bytesize/unit'
#
#   100.gb.to_gib	#=> 93.13225746154785
#
#   2.42.gib.to_mib  #=> 2478.079999923706
#
class ByteSize
	
	
	
	include Comparable
	
	
	
	# :stopdoc:
	SI_BASE = 1000
	SI_ORDERS_OF_MAGNITUDE = {
		kB:	SI_BASE,
		MB:	SI_BASE**2,
		GB:	SI_BASE**3,
		TB:	SI_BASE**4,
		PB:	SI_BASE**5,
		EB:	SI_BASE**6,
		ZB:	SI_BASE**7,
		YB:	SI_BASE**8
		}
	SI_UNIT_SYMBOLS = SI_ORDERS_OF_MAGNITUDE.keys.freeze
	
	IEC_BASE = 1024
	IEC_ORDERS_OF_MAGNITUDE = {
		KiB:   IEC_BASE,
		MiB:   IEC_BASE**2,
		GiB:   IEC_BASE**3,
		TiB:   IEC_BASE**4,
		PiB:   IEC_BASE**5,
		EiB:   IEC_BASE**6,
		ZiB:   IEC_BASE**7,
		YiB:   IEC_BASE**8
		}
	IEC_UNIT_SYMBOLS = IEC_ORDERS_OF_MAGNITUDE.keys.freeze

	ALL_ORDERS_OF_MAGNITUDE = SI_ORDERS_OF_MAGNITUDE.merge(IEC_ORDERS_OF_MAGNITUDE).freeze

	# Must be after ALL_ORDERS_OF_MAGNITUDE
	SI_ORDERS_OF_MAGNITUDE[:bytes] = 1
	SI_ORDERS_OF_MAGNITUDE.freeze

	IEC_ORDERS_OF_MAGNITUDE[:bytes] = 1
	IEC_ORDERS_OF_MAGNITUDE.freeze
	# :startdoc:



	ALL_UNIT_SYMBOLS = ALL_ORDERS_OF_MAGNITUDE.keys.freeze
	


	BASE                = SI_BASE
	UNIT_SYMBOLS        = SI_UNIT_SYMBOLS
	ORDERS_OF_MAGNITUDE = SI_ORDERS_OF_MAGNITUDE
	
	
	
	# :stopdoc:
	# Creates convenience methods for all unit symbols
	ALL_ORDERS_OF_MAGNITUDE.each do |s,om|
		m = s.downcase
		define_singleton_method(m) do |val|
			raise( TypeError, "expected #{Numeric}, got #{val.class}" ) unless val.is_a?(Numeric)
			self.new(( val * om ).round)
		end
		define_method(:"to_#{m}") do
			bytes / Float(om)
		end
	end
	# :startdoc:
	
	
	
	# :stopdoc:
	BYTES_REGEX = /\A\s*(\-?[0-9]+)\s*(bytes)?\s*\z/.freeze
	SI_REGEX    = /\A\s*(\-?[0-9]+(\.[0-9]+)?)\s*(#{ SI_UNIT_SYMBOLS.join('|') })\s*\z/i.freeze
	IEC_REGEX   = /\A\s*(\-?[0-9]+(\.[0-9]+)?)\s*(#{ IEC_UNIT_SYMBOLS.join('|') })\s*\z/i.freeze
	# :startdoc:
	
	
	
	##
	# :call-seq:
	#   ByteSize.bytes( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> bytes.
	#
	def self.bytes( b )
		raise( TypeError, "expected #{Numeric}, got #{b.class}" ) unless b.is_a?(Numeric)
		self.new( b.round )
	end
	
	
	
	##
	# :call-seq:
	#   ByteSize.kb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> kilobytes.
	#
	# :singleton-method: kb
	
	
	
	##
	# :call-seq:
	#   ByteSize.mb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> megabytes.
	#
	# :singleton-method: mb
	
	
	
	##
	# :call-seq:
	#   ByteSize.gb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> gigabytes.
	#
	# :singleton-method: gb
	
	
	
	##
	# :call-seq:
	#   ByteSize.tb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> terabytes.
	#
	# :singleton-method: tb
	
	
	
	##
	# :call-seq:
	#   ByteSize.pb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> petabytes.
	#
	# :singleton-method: pb
	
	
	
	##
	# :call-seq:
	#   ByteSize.eb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> exabytes.
	#
	# :singleton-method: eb
	
	
	
	##
	# :call-seq:
	#   ByteSize.zb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> zettabytes.
	#
	# :singleton-method: zb
	
	
	
	##
	# :call-seq:
	#   ByteSize.yb( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> yottabytes.
	#
	# :singleton-method: yb
	
	
	
	##
	# :call-seq:
	#   ByteSize.kib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> kibibytes.
	#
	# :singleton-method: kib
	
	
	
	##
	# :call-seq:
	#   ByteSize.mib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> mebibytes.
	#
	# :singleton-method: mib
	
	
	
	##
	# :call-seq:
	#   ByteSize.gib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> gibibytes.
	#
	# :singleton-method: gib
	
	
	
	##
	# :call-seq:
	#   ByteSize.tib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> tebibytes.
	#
	# :singleton-method: tib
	
	
	
	##
	# :call-seq:
	#   ByteSize.pib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> pebibytes.
	#
	# :singleton-method: pib
	
	
	
	##
	# :call-seq:
	#   ByteSize.eib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> exbibytes.
	#
	# :singleton-method: eib
	
	
	
	##
	# :call-seq:
	#   ByteSize.zib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> zebibytes.
	#
	# :singleton-method: zib
	
	
	
	##
	# :call-seq:
	#   ByteSize.yib( n )  ->  bytesize
	#
	# Returns a new instance of {ByteSize}[ByteSize.html] representing <em>n</em> yobibytes.
	#
	# :singleton-method: yib
	
	
	
	##
	# call-seq:
	#   ByteSize.parse( string )  ->  bytesize
	#
	# Parses a {String}[https://ruby-doc.org/core/String.html] into either a
	# {ByteSize}[ByteSize.html] or {IECByteSize}[IECByteSize.html] depending on it's unit symbol.
	#
	def self.parse( val )
		if val.is_a?(String)
			if m = val.match(BYTES_REGEX)
				ByteSize.new( m[1].to_i )
			elsif m = val.match(SI_REGEX)
				ByteSize.send( m[3].downcase.to_sym, m[2].nil? ? m[1].to_i : m[1].to_f )
			elsif m = val.match(IEC_REGEX)
				IECByteSize.send( m[3].downcase.to_sym, m[2].nil? ? m[1].to_i : m[1].to_f )
			else
				raise( ArgumentError, "invalid #{ByteSize} or #{IECByteSize} string: #{val.inspect}" )
			end
		else
			raise( TypeError, "expected #{String}, got #{val.class}" )
		end
	end
	
	
	
	# :stopdoc:
	def self.new( val )
		case val
				
			when ByteSize
			super( val.bytes )
			
			when Integer
			super( val )
			
			when String
			if m = val.match(BYTES_REGEX)
				super( m[1].to_i )
			elsif m = val.match(SI_REGEX)
				self.send( m[3].downcase.to_sym, m[2].nil? ? m[1].to_i : m[1].to_f )
			elsif m = val.match(IEC_REGEX)
				self.send( m[3].downcase.to_sym, m[2].nil? ? m[1].to_i : m[1].to_f )
			else
				raise( ArgumentError, "invalid #{self} string: #{val.inspect}" )
			end
			
		else
			raise( TypeError, "no implicit conversion of #{val.class} into #{self}" )	
		end
	end
	# :startdoc:
	
	
	
	##
	# call-seq:
	#   new( integer )
	#   new( string )
	#
	# Create a new instance of {ByteSize}[ByteSize.html] from an {Integer}[https://ruby-doc.org/core/Integer.html]
	# or {String}[https://ruby-doc.org/core/String.html].
	#
	def initialize( bytes )
		@bytes = bytes
	end
	
	
	
	##
	# :call-seq:
	#   to_kb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of kilobytes.
	#
	# :method: to_kb
	
	
	
	##
	# :call-seq:
	#   to_mb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of megabytes.
	#
	# :method: to_mb
	
	
	
	##
	# :call-seq:
	#   to_gb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of gigabytes.
	#
	# :method: to_gb
	
	
	
	##
	# :call-seq:
	#   to_tb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of terabytes.
	#
	# :method: to_tb
	
	
	
	##
	# :call-seq:
	#   to_pb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of petabytes.
	#
	# :method: to_pb
	
	
	
	##
	# :call-seq:
	#   to_eb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of exabytes.
	#
	# :method: to_eb
	
	
	
	##
	# :call-seq:
	#   to_zb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of zettabytes.
	#
	# :method: to_zb
	
	
	
	##
	# :call-seq:
	#   to_yb  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of yottabytes.
	#
	# :method: to_yb
	
	
	
	##
	# :call-seq:
	#   to_kib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of kibibytes.
	#
	# :method: to_kib
	
	
	
	##
	# :call-seq:
	#   to_mib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of mebibytes.
	#
	# :method: to_mib
	
	
	
	##
	# :call-seq:
	#   to_gib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of gibibytes.
	#
	# :method: to_gib
	
	
	
	##
	# :call-seq:
	#   to_tib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of tebibytes.
	#
	# :method: to_tib
	
	
	
	##
	# :call-seq:
	#   to_pib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of pebibytes.
	#
	# :method: to_pib
	
	
	
	##
	# :call-seq:
	#   to_eib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of exbibytes.
	#
	# :method: to_eib
	
	
	
	##
	# :call-seq:
	#   to_zib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of zebibytes.
	#
	# :method: to_zib
	
	
	
	##
	# :call-seq:
	#   to_yib  ->  float
	#
	# Returns a {Float}[https://ruby-doc.org/core/Float.html] representing the equivalent number of yobibytes.
	#
	# :method: to_yib
	
	
	
	##
	# :call-seq:
	#   bytesize < val  ->  true or false
	#
	# Returns <code>true</code> if the value of <em>bytesize</em> is less than that of <em>val</em>.
	#
	def <( other )
		case other
			
			when ByteSize
			bytes < other.bytes
			
			when Numeric
			bytes < other
			
		else 
			raise( ArgumentError, "comparison of #{self.class} with #{other.inspect} failed" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize <= val  ->  true or false
	#
	# Returns <code>true</code> if the value of <em>bytesize</em> is less than or equal to that of <em>val</em>.
	#
	def <=( other )
		case other
			
			when ByteSize
			bytes <= other.bytes
			
			when Numeric
			bytes <= other
			
		else 
			raise( ArgumentError, "comparison of #{self.class} with #{other.inspect} failed" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize > val  ->  true or false
	#
	# Returns <code>true</code> if the value of <em>bytesize</em> is greater than that of <em>val</em>.
	#
	def >( other )
		case other
			
			when ByteSize
			bytes > other.bytes
			
			when Numeric
			bytes > other
			
		else 
			raise( ArgumentError, "comparison of #{self.class} with #{other.inspect} failed" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize >= val  ->  true or false
	#
	# Returns <code>true</code> if the value of <em>bytesize</em> is greater than or equal to that of <em>val</em>.
	#
	def >=( other )
		case other
			
			when ByteSize
			bytes >= other.bytes
			
			when Numeric
			bytes >= other
			
		else 
			raise( ArgumentError, "comparison of #{self.class} with #{other.inspect} failed" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize % val  ->  bytesize
	#
	# Performs a modulo operation with <em>val</em>, returning an instance of {ByteSize}[ByteSize.html].
	#
	# <em>val</em> can be another {ByteSize}[ByteSize.html] or a {Numeric}[https://ruby-doc.org/core/Numeric.html].
	#
	def %( val )
		case val
			
			when Numeric
			self.class.new(( bytes % val ).round)
			
			when ByteSize
			self.class.new( bytes % val.bytes )
			
		else 
			raise( TypeError, "#{val.class} can't be coerced into #{self.class}" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize * val  ->  bytesize
	#
	# Performs multiplication, returning an instance of {ByteSize}[ByteSize.html].
	#
	# <em>val</em> must be a {Numeric}[https://ruby-doc.org/core/Numeric.html].
	# Multiplication with another {ByteSize}[ByteSize.html] is disallowed because it does not make symantic sense.
	#
	def *( val )
		case val
			
			when Numeric
			self.class.new(( bytes * val ).round)
			
			when ByteSize
			raise( TypeError, "cannot multiply #{ByteSize} with #{val.class}" )
			
		else 
			raise( TypeError, "#{val.class} can't be coerced into #{self.class}" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize ** pow  ->  bytesize
	#
	# Raises <em>bytesize</em> to the power of <em>pow</em>, returning an instance of {ByteSize}[ByteSize.html].
	#
	# <em>pow</em> must be a {Numeric}[https://ruby-doc.org/core/Numeric.html].
	# Raising to the power of another {ByteSize}[ByteSize.html] is disallowed because it does not make symantic sense.
	#
	def **( pow )
		case pow
			
			when Numeric
			self.class.new(( bytes ** pow ).round)
			
			when ByteSize
			raise( TypeError, "cannot raise #{ByteSize} to a power of #{pow.class}" )
			
		else 
			raise( TypeError, "#{pow.class} can't be coerced into #{self.class}" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize + val  ->  bytesize
	#
	# Performs addition, returning an instance of {ByteSize}[ByteSize.html].
	#
	# <em>val</em> can be another {ByteSize}[ByteSize.html] or a {Numeric}[https://ruby-doc.org/core/Numeric.html].
	#
	def +( val )
		case val
			
			when Numeric
			self.class.new(( bytes + val ).round)
			
			when ByteSize
			self.class.new( bytes + val.bytes )
			
		else 
			raise( TypeError, "#{val.class} can't be coerced into #{self.class}" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   +bytesize  ->  bytesize
	#
	# Unary Plus — Returns the receiver’s value.
	#
	def +@
		self
	end
	
	
	
	##
	# :call-seq:
	#   bytesize - val  ->  bytesize
	#
	# Performs subtraction, returning an instance of {ByteSize}[ByteSize.html].
	#
	# <em>val</em> can be another {ByteSize}[ByteSize.html] or a {Numeric}[https://ruby-doc.org/core/Numeric.html].
	#
	def -( val )
		case val
			
			when Numeric
			self.class.new(( bytes - val ).round)
			
			when ByteSize
			self.class.new( bytes - val.bytes )
			
		else 
			raise( TypeError, "#{val.class} can't be coerced into #{self.class}" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   -bytesize  ->  bytesize
	#
	# Unary Minus — Returns the receiver’s value, negated.
	#
	def -@
		self.class.new( 0 - bytes )
	end
	
	
	
	##
	# :call-seq:
	#   bytesize / val  ->  bytesize or float
	#
	# Performs division.
	#
	# If <em>val</em> is a {Numeric}[https://ruby-doc.org/core/Numeric.html]
	# it returns an instance of {ByteSize}[ByteSize.html].
	# If <em>val</em> is an instance of {ByteSize}[ByteSize.html] it returns
	# a {Float}[https://ruby-doc.org/core/Float.html].
	#
	def /( val )
		case val
			
			when Numeric
			self.class.new(( bytes / val ).round)
			
			when ByteSize
			bytes.to_f / val.bytes.to_f
			
		else 
			raise( TypeError, "#{val.class} can't be coerced into #{self.class}" )
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize <=> other  ->  -1, 0, 1, or nil
	#
	# Compares <em>bytesize</em> to <em>other</em> and returns <code>0</code> if they are equal,
	# <code>-1</code> if <em>bytesize</em> is less than <em>other</em>,
	# or <code>1</code> if <em>bytesize</em> is greater than <em>other</em>.
	#
	# Returns <code>nil</code> if the two values are incomparable.
	#
	def <=>( other )
		case other
			
			when Numeric
			bytes <=> other
			
			when ByteSize
			bytes <=> other.bytes
			
		else 
			nil
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize == other  ->  true or false
	#
	# Returns <code>true</code> if <em>bytesize</em> is equal to <em>other</em>.
	#
	# If <em>other</em> is not an instance of {ByteSize}[ByteSize.html] an attempt will be made to convert it to one.
	#
	def ==( other )
		case other
			
			when Numeric
			bytes == other
			
			when ByteSize
			bytes == other.bytes
			
		else 
			false
		end
	end
	
	
	
	##
	# :call-seq:
	#   bytesize === other  ->  true or false
	#
	# Alias for<i> {==}[#method-i-3D-3D]</i>.
	#
	# :method: ===
		
	# :stopdoc:
	alias_method :===, :==
	# :startdoc:
	
	
	
	##
	# :call-seq:
	#   bytes  ->  integer
	#
	# Returns the number of bytes as an {Integer}[https://ruby-doc.org/core/Integer.html].
	#
	# :method: bytes
		
	# :stopdoc:
	attr_accessor :bytes
	# :startdoc:
	
	
	
	# :stopdoc:
	def coerce( other )
		if Numeric
			[ other, self.to_i ]
		else
			begin
				[ self.class.new(other), self ]
			rescue
				raise( TypeError, "#{other.class} can't be coerced into #{self.class}" )
			end
		end
	end
	# :startdoc:
	
	
	
	##
	# :call-seq:
	#   eql?( other_bytesize )  ->  true or false
	#
	# Returns <code>true</code> if the {ByteSize}[ByteSize.html] is equal to <em>other_bytesize</em>.
	#
	def eql?( other )
		other.class == self.class && other.bytes == bytes
	end
	
	
	
	# :stopdoc:
	def hash
		bytes.hash
	end
	# :startdoc:
	
	
	
	##
	# :call-seq:
	#   inspect  ->  string
	#
	# Return a {String}[https://ruby-doc.org/core/String.html] describing this object.
	#
	# ====== Example:
	#
	#   ByteSize.bytes(3000000000000)  #=> (3 TB)
	#
	def inspect
		sprintf( '(%s)', to_s )
	end
	
	
	
	##
	# :call-seq:
	#   negative?  ->  true or false
	#
	# Returns <code>true</code> if the {ByteSize}[ByteSize.html] is less than <code>0</code>.
	#
	def negative?
		bytes < 0
	end
	
	
	
	##
	# :call-seq:
	#   positive?  ->  true or false
	#
	# Returns <code>true</code> if the {ByteSize}[ByteSize.html] is greater than <code>0</code>.
	#
	def positive?
		bytes > 0
	end
	
	
	
	##
	# :call-seq:
	#   to_bytes  ->  integer
	#
	# Alias for<i> #bytes</i>.
	#
	# :method: to_bytes
		
	# :stopdoc:
	alias_method :to_bytes, :bytes
	# :startdoc:
	
	
	
	##
	# :call-seq:
	#   to_i  ->  integer
	#
	# Returns the number of bytes as an {Integer}[https://ruby-doc.org/core/Integer.html].
	#
	def to_i
		bytes.to_i
	end
	
	
	
	##
	# :call-seq:
	#   to_iec  ->  iecbytesize
	#
	# Returns the size as an instance of {IECByteSize}[IECByteSize.html].
	#
	# If called on an instance of {IECByteSize}[IECByteSize.html] it returns <code>self</code>.
	#
	def to_iec
		self.class == IECByteSize ? self : IECByteSize.new(self.to_i)
	end
	
	
	
	##
	# :call-seq:
	#   to_s  ->  string
	#   to_s( decimal_places )  ->  string
	#
	# Format this {ByteSize}[ByteSize.html] as a {String}[https://ruby-doc.org/core/String.html].
	#
	# The second form formats it with exactly <em>decimal_places</em> decimal places.
	#
	# ====== Example:
	#
	#   ByteSize.bytes(3000000000000).to_s	 #=> "3 TB"
	#   ByteSize.bytes(2460000000000).to_s	 #=> "2.46 TB"
	#
	#   ByteSize.bytes(3000000000000).to_s(2)  #=> "3.00 TB"
	#   ByteSize.bytes(1234567890000).to_s(2)  #=> "1.23 TB"
	#   ByteSize.bytes(1234567890000).to_s(4)  #=> "1.2346 TB"
	#
	def to_s( decimal_places=nil )
		unless decimal_places.nil?
			raise( TypeError, "expected #{Integer}, got #{decimal_places.class}" ) unless decimal_places.is_a?(Integer)
			raise( RangeError, "decimal places cannot be negative" ) unless decimal_places >= 0
		end
		
		b = bytes.abs
		
		scale = self.class::ORDERS_OF_MAGNITUDE.sort{|(ak,av),(bk,bv)| av <=> bv }
		
		if b == 0
			unit = scale.first
		else
			unit = scale.find_index{|k,v| v > b }
			if unit.nil?
				unit = scale.last
			else
				unit = scale[unit-1]
			end
		end
		
		if decimal_places.nil?
			sprintf( negative? ? '-%g %s' : '%g %s', ((b/Float(unit.last))*100).round/100.0, unit.first.to_s )
		else
			sprintf( negative? ? "-%.0#{decimal_places}f %s" : "%.0#{decimal_places}f %s", b / Float(unit.last), unit.first.to_s )
		end
	end
	
	
	
	##
	# :call-seq:
	#   to_si  ->  bytesize
	#
	# Returns the size as an instance of {ByteSize}[ByteSize.html].
	#
	# If called on an instance of {ByteSize}[ByteSize.html] it returns <code>self</code>.
	#
	def to_si
		self.class == ByteSize ? self : ByteSize.new(self.to_i)
	end
	
	
	
	##
	# :call-seq:
	#   zero?  ->  true or false
	#
	# Returns <code>true</code> if the {ByteSize}[ByteSize.html] has a zero value.
	#
	def zero?
		bytes == 0
	end
	
	
	
	
	
	
	
end



# This class is identical to <i>{ByteSize}[ByteSize.html]</i> except that all formatted output uses
# the {IEC}[https://en.wikipedia.org/wiki/ISO/IEC_80000] standard unit symbols:
# KiB, MiB, GiB, TiB, PiB, EiB, ZiB, YiB.
#
# === Examples of use:
#
#   IECByteSize.new( 4127 )	  #=> (4.03 KiB)
#   IECByteSize.new( "22 GB" )   #=> (20.49 GiB)
#   IECByteSize.new( "22 GiB" )  #=> (22 GiB)
#
#   IECByteSize.bytes( 42 )	  #=> (42 bytes)
#
#   IECByteSize.kib( 42 )		#=> (42 KiB)
#   IECByteSize.mib( 42 )		#=> (42 MiB)
#   IECByteSize.gib( 42 )		#=> (42 GiB)
#   IECByteSize.tib( 42 )		#=> (42 TiB)
#   IECByteSize.pib( 42 )		#=> (42 PiB)
#   IECByteSize.eib( 42 )		#=> (42 EiB)
#   IECByteSize.zib( 42 )		#=> (42 ZiB)
#   IECByteSize.yib( 42 )		#=> (42 YiB)
#
class IECByteSize < ByteSize
	
	# :stopdoc:
	BASE                = IEC_BASE
	UNIT_SYMBOLS        = IEC_UNIT_SYMBOLS
	ORDERS_OF_MAGNITUDE = IEC_ORDERS_OF_MAGNITUDE
	# :startdoc:
	
end



# {ByteSize}[ByteSize.html] adds three new methods to the {File}[http://ruby-doc.org/core/File.html] class:
#
# * <i> ::bytesize</i>
# * <i> ::bytesize?</i>
# * <i> #bytesize</i>
#
# Plus the equivalent methods for {IECByteSize}[IECByteSize.html]:
#
# * <i> ::iecbytesize</i>
# * <i> ::iecbytesize?</i>
# * <i> #iecbytesize</i>
#
class File
	
	
	
	##
	# :call-seq:
	#   File.bytesize( file_name )  ->  bytesize
	#
	# Identical to<i> {File.size}[http://ruby-doc.org/core/File.html#method-c-size]</i>
	# except that the value is returned as an instance of {ByteSize}[ByteSize.html].
	#
	def self.bytesize( file_name )
		ByteSize.new( self.size(file_name) )
	end
	
	
	
	##
	# :call-seq:
	#   File.bytesize?( file_name )  ->  bytesize or nil
	#
	# Identical to<i> {File.size?}[http://ruby-doc.org/core/File.html#method-c-size-3F]</i>
	# except that the value is returned as an instance of {ByteSize}[ByteSize.html].
	#
	def self.bytesize?( file_name )
		sz = self.size?(file_name)
		sz.nil? ? nil : ByteSize.new(sz)
	end
	
	
	
	##
	# :call-seq:
	#   bytesize  ->  bytesize
	#
	# Identical to<i> {File#size}[http://ruby-doc.org/core/File.html#method-i-size]</i>
	# except that the value is returned as an instance of {ByteSize}[ByteSize.html].
	#
	def bytesize
		ByteSize.new(size)
	end
	
	
	
	##
	# :call-seq:
	#   File.iecbytesize( file_name )  ->  bytesize
	#
	# Identical to<i> {File.size}[http://ruby-doc.org/core/File.html#method-c-size]</i>
	# except that the value is returned as an instance of {IECByteSize}[IECByteSize.html].
	#
	def self.iecbytesize( file_name )
		IECByteSize.new( self.size(file_name) )
	end
	
	
	
	##
	# :call-seq:
	#   File.iecbytesize?( file_name )  ->  bytesize or nil
	#
	# Identical to<i> {File.size?}[http://ruby-doc.org/core/File.html#method-c-size-3F]</i>
	# except that the value is returned as an instance of {IECByteSize}[IECByteSize.html].
	#
	def self.iecbytesize?( file_name )
		sz = self.size?(file_name)
		sz.nil? ? nil : IECByteSize.new(sz)
	end
	
	
	
	##
	# :call-seq:
	#   iecbytesize  ->  bytesize
	#
	# Identical to<i> {File#size}[http://ruby-doc.org/core/File.html#method-i-size]</i>
	# except that the value is returned as an instance of {IECByteSize}[IECByteSize.html].
	#
	def iecbytesize
		IECByteSize.new(size)
	end
	
	
	
end



# ByteSize adds two new methods to the {Pathname}[https://ruby-doc.org/stdlib/libdoc/pathname/rdoc/Pathname.html] class:
#
# * <i> #bytesize</i>
# * <i> #bytesize?</i>
#
# Plus the equivalent methods for {IECByteSize}[IECByteSize.html]:
#
# * <i> #iecbytesize</i>
# * <i> #iecbytesize?</i>
#
class Pathname
	
	
	
	##
	# :call-seq:
	#   bytesize  ->  bytesize
	#
	# Identical to<i> {Pathname#size}[https://ruby-doc.org/stdlib/libdoc/pathname/rdoc/Pathname.html#method-i-size]</i>
	# except that the value is returned as an instance of {ByteSize}[ByteSize.html].
	#
	def bytesize
		ByteSize.new(size)
	end
	
	
	
	##
	# :call-seq:
	#   bytesize?  ->  bytesize or nil
	#
	# Identical to<i> {Pathname#size?}[https://ruby-doc.org/stdlib/libdoc/pathname/rdoc/Pathname.html#method-i-size-3F]</i>
	# except that the value is returned as an instance of {ByteSize}[ByteSize.html].
	#
	def bytesize?
		sz = size?
		sz.nil? ? nil : ByteSize.new(sz)
	end
	
	
	
	##
	# :call-seq:
	#   iecbytesize  ->  bytesize
	#
	# Identical to<i> {Pathname#size}[https://ruby-doc.org/stdlib/libdoc/pathname/rdoc/Pathname.html#method-i-size]</i>
	# except that the value is returned as an instance of {IECByteSize}[IECByteSize.html].
	#
	def iecbytesize
		IECByteSize.new(size)
	end
	
	
	
	##
	# :call-seq:
	#   iecbytesize?  ->  bytesize or nil
	#
	# Identical to<i> {Pathname#size?}[https://ruby-doc.org/stdlib/libdoc/pathname/rdoc/Pathname.html#method-i-size-3F]</i>
	# except that the value is returned as an instance of {IECByteSize}[IECByteSize.html].
	#
	def iecbytesize?
		sz = size?
		sz.nil? ? nil : IECByteSize.new(sz)
	end
	
	
	
end