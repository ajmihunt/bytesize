# ByteSize

ByteSize is a simple Ruby object that stores a size in bytes, while providing human-readable string output and ample convenience methods.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bytesize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bytesize

## Usage

### New

An instance of ByteSize can be created from an [Integer](https://ruby-doc.org/core/Integer.html) representing a number of bytes:

```ruby
require 'bytesize'

ByteSize.new(1210000000)  #=> (1.21 GB)
```

Or a [String](https://ruby-doc.org/core/String.html) containing a human-readable representation:

```ruby
ByteSize.new("1.21 GB")  #=> (1.21 GB)
```

Appropriate conversions are made between different unit symbols:

```ruby
ByteSize.new("1.1269 GiB")  #=> (1.21 GB)
```

ByteSize has a number of convenience methods for all SI and IEC unit symbols:

```ruby
ByteSize.bytes(42)  #=> (42 bytes)

ByteSize.kb(42)     #=> (42 kB)
ByteSize.mb(42)     #=> (42 MB)
ByteSize.gb(42)     #=> (42 GB)
ByteSize.tb(42)     #=> (42 TB)
ByteSize.pb(42)     #=> (42 PB)
ByteSize.eb(42)     #=> (42 EB)
ByteSize.zb(42)     #=> (42 ZB)
ByteSize.yb(42)     #=> (42 YB)

ByteSize.kib(42)    #=> (43.01 kB)
ByteSize.mib(42)    #=> (44.04 MB)
ByteSize.gib(42)    #=> (45.1 GB)
ByteSize.tib(42)    #=> (46.18 TB)
ByteSize.pib(42)    #=> (47.29 PB)
ByteSize.eib(42)    #=> (48.42 EB)
ByteSize.zib(42)    #=> (49.58 ZB)
ByteSize.yib(42)    #=> (50.77 YB)
```

### String Output

ByteSize formats all [String](https://ruby-doc.org/core/String.html) output using SI standard unit symbols:

```ruby
ByteSize.zb(42).to_s  #=> "42 ZB"
```

If you wish to display sizes using IEC standard unit symbols instead, you can use the sister-class [IECByteSize](../classes/IECByteSize.html):

```ruby
IECByteSize.zib(42).to_s  #=> "42 ZiB"
IECByteSize.kib(64).to_s  #=> "64 KiB"
```

An optional [Integer](https://ruby-doc.org/core/Integer.html) can be provided to define a fixed number of decimal places:

```ruby
ByteSize.tb(3).to_s(4)        #=> "3.0000 TB"
ByteSize.mb(1.14159).to_s(4)  #=> "1.1416 MB"
```

### Conversion

ByteSize includes conversion methods for all SI and IEC unit symbols:

```ruby
ByteSize.gb(1.21).to_bytes  #=> 1210000000

ByteSize.gb(1.21).to_kb     #=> 1210000.0
ByteSize.gb(1.21).to_mb     #=> 1210.0
ByteSize.gb(1.21).to_gb     #=> 1.21
ByteSize.gb(1.21).to_tb     #=> 0.00121
ByteSize.gb(1.21).to_pb     #=> 1.21e-06
ByteSize.gb(1.21).to_eb     #=> 1.21e-09
ByteSize.gb(1.21).to_zb     #=> 1.21e-12
ByteSize.gb(1.21).to_yb     #=> 1.21e-15

ByteSize.gb(1.21).to_kib     #=> 1181640.625
ByteSize.gb(1.21).to_mib     #=> 1153.9459228515625
ByteSize.gb(1.21).to_gib     #=> 1.126900315284729
ByteSize.gb(1.21).to_tib     #=> 0.0011004885891452432
ByteSize.gb(1.21).to_pib     #=> 1.0746958878371515e-06
ByteSize.gb(1.21).to_eib     #=> 1.0495077029659683e-09
ByteSize.gb(1.21).to_zib     #=> 1.0249098661777034e-12
ByteSize.gb(1.21).to_yib     #=> 1.0008885411891635e-15
```

### Numeric Unit Symbols

If <code>bytesize-unit</code> is required, convenience methods for all SI and IEC unit symbols are added to the [Numeric](https://ruby-doc.org/core/Numeric.html) class, simplifying the syntax:

```ruby
require 'bytesize-unit'

1.21.gb       #=> (1.21 GB)
42.zb         #=> (42 ZB)

55.mb * 4     #=> (220 MB)

6.2.tb.to_kb  #=> 6200000000.0
```

### Math Operations

Standard mathematical operations work with ByteSize:

```ruby
ByteSize.mb(55) + ByteSize.kb(64)  #=> (55.06 MB)

ByteSize.mb(22) * 5                #=> (110 MB)

2 * ByteSize.tb(3)                 #=> (6 TB)

ByteSize.mb(100) / 16              #=> (6.25 MB)

[ 55.mb, 64.kb, 22.mb, 100.mb ].inject( ByteSize.new(0) ){|t,sz| t += sz }  #=> (177.06 MB)
```

### Integration with File and Pathname

ByteSize adds additional methods to File and Pathname that can be used to retrieve a file's size in ByteSize format:

```ruby
File.bytesize('VoyageDansLaLune.384400.dpx')  #=> (12.75 MB)

# Get the total size of all JPEGs in a folder
Pathname.glob('pictures/*.jpg').inject( ByteSize.new(0) ){|t,f| t += f.bytesize }  #=> (26.24 MB)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ajmihunt/bytesize.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
