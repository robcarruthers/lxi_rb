# lxi_rb

[![Gem Version](https://img.shields.io/gem/v/lxi_rb?color=green)](https://badge.fury.io/rb/lxi_rb) ![Ruby](https://img.shields.io/static/v1?message=Ruby&color=red&logo=Ruby&logoColor=FFFFFF&label=v3.2.2+yjit) ![Ruby](https://img.shields.io/gitlab/license/robcarruthers/rfbeam?color=orange)

Ruby wrapper for the [liblxi](https://github.com/lxi-tools/liblxi) library, which offers a simple API for communicating with LXI compatible instruments.

## Installation

The gem requires the liblxi library to be installed on the system. The library can be installed and macOS or Linux using [Homebrew](https://brew.sh/)

```shell
brew install liblxi
```

Install the gem and add to the application's Gemfile by executing:

```shell
bundle add lxi_rb
```

If bundler is not being used to manage dependencies, install the gem by executing:

```shell
gem install lxi_rb
```

## Usage

```ruby
Lxi::Device.new('192.168.10.107') do |multimeter|
    multimeter.send 'MEAS:VOLT:DC?'
    sleep 0.05
    result = multimeter.read 512
    puts Float(result)
end
=> -0.000478767775E-04
```

### NetFinder

The Lxi module provides a NetFinder class for searching for LXI devices on the network and a Device class for communicating with LXI devices.

NetFinder will broadcast a UDP packet to the network and wait for responses from LXI devices. The search method will return an array of hashes containing the IP address and identification string of each device found. By default, the search method will use the VXI-11 UDP broadcast method, but can be configured to use mDNS with the :mdns option.

```ruby
net = Lxi::NetFinder.new
=> <Lxi::NetFinder:0x00000001047fc538>

net.search
=> [{:address=>"192.168.10.197", :id=>"RIGOL TECHNOLOGIES,M300,MM3A250200001,04.02.00.08.00"}]

irb(main):003:0> net.search :mdns
=> [{:address=>"192.168.10.109", :id=>"dummy-scope LXI", :service=>"lxi", :port=>12345}]
```

### Device API

The Lxi module provides a Device class for communicating with LXI devices. The Device class can be initialized with an IP address. The Device class will attempt to connect to the device when initialized and will raise an exception if the connection fails. The Device class can also be initialized with a block, which will yield the Device object to the block and close the connection when the block exits.

```ruby
device = Lxi::Device.new('192.168.10.197')
```

#### write(message) -> int

The write method will send a string to the device and return the number of bytes written.

```ruby
device.write 'MEAS:VOLT:DC?'
=> 13
```

#### read(512) -> String

The read method will read the specified number of bytes from the device and return a string.

```ruby
device.read 512
=> "-4.90147020E-04\n"
```

#### query(message, bytes = 512, resp_delay: 0.02) -> String

The query method will send a string to the device, read the optional number of bytes from the device and return a string. It also accepts an optional :resp_delay parameter, which will delay the read operation by the specified number of seconds.

```ruby
device.query 'MEAS:VOLT:DC?', 512, resp_delay: 0.05
=> "-4.97235730E-04\n"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/robcarruthers/lxi_rb>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
