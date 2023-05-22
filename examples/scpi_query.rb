# frozen_string_literal: true
require 'optparse'
require_relative '../lib/lxi_rb'

# Example: SCPI Query LXI devices on the LAN
# Usage: ruby scpi_query.rb --address 192.168.10.109 --command *IDN?
# -a, --address IP_ADDRESS         Device IP address
# -c, --command COMMAND            Device command

options = {}
op =
  OptionParser.new do |opts|
    opts.banner = 'Usage: query_device.rb [options]'

    opts.on('-a', '--address IP_ADDRESS', 'Device IP address (*required)') { |ip| options[:address] = ip }
    opts.on('-c', '--command COMMAND', "Device command (default = '*IDN?')") { |cmd| options[:command] = cmd }
    opts.on('-R', '--read_bytes BYTES', 'Bytes to read back from Device (default = 512') do |bytes|
      options[:bytes] = bytes
    end
  end
op.parse!

# Check for address
unless options[:address]
  puts op
  exit
end

# Initialize LXI library
Lxi.init_session

# Create a new LXI device
address = options[:address] || ''
device_type = :vxi11
command = options[:command] || '*IDN?'
bytes = options[:bytes] || 512

Lxi::Device.new(address, device_type) do |device|
  device.write(command)
  sleep 0.05
  puts device.read bytes
end
