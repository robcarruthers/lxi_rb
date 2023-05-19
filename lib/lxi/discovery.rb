# frozen_string_literal: true
module Lxi
  # Search for LXI-11 instruments on the network and return array of instruments
  def self.search(timeout: 1000, type: :vxi11)
    raise(Error, 'LXI Library Initialisation Error') unless lxi_init == LXI_OK

    devices = []
    device_callback =
      FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
        devices << { address: address.read_string, id: id.read_string }
      end

    info = FFIFunctions::LxiInfo.new
    info[:device] = device_callback

    result = lxi_discover_internal(info, timeout, type)
    raise(Error, "Discovery error: #{result}") unless result == LXI_OK

    sleep(0.5)
    devices
  end

  def self.asdf
    puts 'asdf'
  end

  # Discover LXI-11 devices on the LAN
  def self.discover(timeout: 1000, type: :vxi11)
    Lxi.init_lxi_session

    info = FFIFunctions::LxiInfo.new
    info[:broadcast] = BroadcastCallback
    info[:device] = DeviceCallback

    puts("Searching for LXI devices - please wait...\n\n")

    result = lxi_discover_internal(info, timeout, type)

    puts("Error during discovery: #{result}") if result.negative?
  end
end
