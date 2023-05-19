# frozen_string_literal: true
require_relative '../lib/lxi_rb'

# Initialize LXI library
Lxi.init_lxi_session

# Lxi.search will return an Array of device identifiers and IP addresses
devices = Lxi.search
abort 'No devices found' if devices.nil? || devices.empty?

# Create a new LXI device
device_ip_address = devices[0][:address]
device_type = :vxi11
command = '*IDN?'

Lxi::Device.new(device_ip_address, device_type) do |device|
  device.send command
  sleep 0.05
  puts device.read 512
end
