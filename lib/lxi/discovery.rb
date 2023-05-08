module Lxi
  # Search for LXI-11 devices on the specified interface and return hash of devices
  def self.devices(timeout: 1000, type: :vxi11)
    raise Error, 'LXI Library Initialisation Error' unless lxi_init == LXI_OK

    devices = []
    device_callback =
      FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
        devices << { address: address.read_string, id: id.read_string }
      end

    info = FFIFunctions::LxiInfo.new
    info[:device] = device_callback

    lxi_discover_internal(info, timeout, type)
    sleep 0.1
    devices
  end

  # Discover LXI-11 devices on the LAN
  def self.discover_local(timeout: 1000, type: :vxi11)
    Lxi.init_lxi_session

    info = FFIFunctions::LxiInfo.new
    info[:broadcast] = BroadcastCallback
    info[:device] = DeviceCallback

    puts "Searching for LXI devices - please wait...\n\n"

    result = lxi_discover_internal(info, timeout, type)

    puts "Error during discovery: #{result}" if result.negative?
  end
end
