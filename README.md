# lxi_rb

[![Gem Version](https://badge.fury.io/rb/lxi_rb.svg)](https://badge.fury.io/rb/lxi_rb) ![Ruby](https://img.shields.io/static/v1?message=Ruby&color=red&logo=Ruby&logoColor=FFFFFF&label=v3.1.2) ![Ruby](https://img.shields.io/gitlab/license/robcarruthers/rfbeam?color=orange)

Ruby wrapper for the [liblxi](https://github.com/lxi-tools/liblxi) library.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add lxi_rb

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install lxi_rb

## Usage

```ruby
Lxi.search
Searching for LXI devices - please wait...

Broadcast: 127.0.0.1, lo0
Broadcast: 192.168.10.255, en0
Device: 192.168.10.21, Siglent Technologies,SDS1104X-E,SDSMMGKC6R0011,8.2.6.1.37R8
Device: 192.168.10.107, Siglent Technologies,SDM3055-SC,SDM35GBQ6R1882,1.01.01.25

Lxi.discover_instruments
=> [{:address=>"192.168.10.107", :id=>"Siglent Technologies,SDM3055-SC,SDM35GBQ6R1882,1.01.01.25"}]

Lxi::Device.new('192.168.10.107', :vxi11) do |meter|
    puts meter.query 'MEAS:VOLT:DC?'
end
=> -4.78767775E-04
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lxi_rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
