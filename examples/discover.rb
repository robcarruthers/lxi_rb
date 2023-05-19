# frozen_string_literal: true
require 'ffi'
require_relative '../lib/lxi_rb'

# Discovery Callbacks
BroadcastCallback =
  FFI::Function.new(:void, %i[pointer pointer]) do |address, interface|
    puts("Broadcast: #{address.read_string}, #{interface.read_string}\n")
  end

DeviceCallback =
  FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
    puts("\n    Found #{id.read_string} on address #{address.read_string}\n    lxi service on port 80")
  end

ServiceCallback =
  FFI::Function.new(:void, %i[pointer pointer pointer int]) do |address, id, service, port|
    puts("Service: #{address.read_string}, #{id.read_string}, #{service.read_string}, #{port}")
  end

# Discover LXI-11 devices on the LAN
timeout_ms = 1000
# Search types, Bonjour :mdns or VXI-11 :vxi11 (default)
search_type = :vxi11

Lxi.init_lxi_session
info = Lxi::FFIFunctions::LxiInfo.new
info[:broadcast] = BroadcastCallback
info[:device] = DeviceCallback

puts("Searching for LXI devices - please wait...\n\n")

result = Lxi.lxi_discover_internal(info, timeout_ms, search_type)
puts("Error during discovery: #{result}") if result.negative?
