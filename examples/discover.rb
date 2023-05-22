# frozen_string_literal: true

# Example: Discover LXI devices on the LAN
# Usage: ruby discover.rb [options]
# Usage: ruby discover.rb --timeout_ms 1000 --search_type :vxi11
#  -t, --timeout_ms TIMEOUT         Timeout in milliseconds
#  -s, --search_type type           Search Type, vxi11 or mdns

require 'ffi'
require 'optparse'
require_relative '../lib/lxi_rb'

options = {}
op =
  OptionParser.new do |opts|
    opts.banner = 'Usage: discover.rb [options]'

    opts.on('-t', '--timeout_ms TIMEOUT', 'Timeout in milliseconds') do |timeout|
      options[:timeout_ms] = Integer(timeout, 10)
    end
    opts.on('-s', '--search_type type', "Search Type, 'vxi11' or 'mdns'") do |param|
      options[:search_type] = param.is_a?(Symbol) ? param : param.to_sym
    end
  end
op.parse!

# Discovery Callbacks
BroadcastCallback =
  FFI::Function.new(:void, %i[pointer pointer]) do |address, interface|
    puts("Broadcast: #{address.read_string}, #{interface.read_string}\n")
  end

DeviceCallback =
  FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
    puts("    Found #{id.read_string} on address #{address.read_string}")
  end

ServiceCallback =
  FFI::Function.new(:void, %i[pointer pointer pointer int]) do |address, id, service, port|
    puts("  Found: #{id.read_string} on address #{address.read_string},")
    puts("    Service type: #{service.read_string}, on port: #{port}")
  end

# Discover LXI-11 devices on the LAN
timeout_ms = options[:timeout_ms] || 1000
# Search types, Bonjour :mdns or VXI-11 :vxi11 (default)
search_type = options[:search_type] || :vxi11

# Initialize LXI session
Lxi.init_session

# Setup discovery callbacks
info = Lxi::FFIFunctions::LxiInfo.new
info[:broadcast] = BroadcastCallback
info[:device] = DeviceCallback
info[:service] = ServiceCallback

# Start discovery
puts("\nSearching for LXI devices \n  Search type: #{search_type} - please wait...\n\n")
result = Lxi.discover(info, timeout_ms, search_type)
puts("Error during discovery: #{result}") if result.negative?
