# lxi_rb

[![Gem Version](https://img.shields.io/gem/v/lxi_rb?color=green)](https://badge.fury.io/rb/lxi_rb) ![Ruby](https://img.shields.io/static/v1?message=Ruby&color=red&logo=Ruby&logoColor=FFFFFF&label=v3.1.2) ![Ruby](https://img.shields.io/gitlab/license/robcarruthers/rfbeam?color=orange)

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

```irb
❯ bin/console
irb(main):001:0> net = Lxi::NetFinder.new
=> #<Lxi::NetFinder:0x00000001047fc538>

irb(main):002:0> net.search
=> [{:address=>"192.168.10.197", :id=>"RIGOL TECHNOLOGIES,M300,MM3A250200001,04.02.00.08.00"}, {:address=>"192.168.10.113", :id=>"Siglent Technologies,SDM3055-SC,SDM35GBQ6R1882,1.01.01.25"}]

irb(main):003:0> net.search :mdns
=> [{:address=>"192.168.10.109", :id=>"dummy-scope LXI", :service=>"lxi", :port=>12345},
 {:address=>"192.168.10.109", :id=>"dummy-scope VXI-11", :service=>"vxi-11", :port=>111},
 {:address=>"192.168.10.109", :id=>"dummy-scope SCPI", :service=>"scpi-raw", :port=>5025},
 {:address=>"192.168.10.109", :id=>"dummy-scope SCPI Telnet", :service=>"scpi-telnet", :port=>5026},
 {:address=>"192.168.10.109", :id=>"dummy-scope HiSLIP", :service=>"hislip", :port=>4880}]

irb(main):004:1* Lxi::Device.new('192.168.10.107') do |meter|
irb(main):005:1*     meter.send 'MEAS:VOLT:DC?'
irb(main):006:1*     sleep 0.05
irb(main):007:1*     result = meter.read 512
irb(main):008:1*     puts Float(result)
irb(main):009:0> end
=> -0.000478767775E-04
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/robcarruthers/lxi_rb>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
