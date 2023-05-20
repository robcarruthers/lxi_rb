# frozen_string_literal: true
module Lxi
  class NetFinder
    include FFI

    def init
      @devices = []
    end

    # Search for LXI-11 instruments on the network and return array of instruments
    def search(timeout: 1000, type: :vxi11)
      raise(Error, 'LXI Library Initialisation Error') unless Lxi.lxi_init == LXI_OK

      info = FFIFunctions::LxiInfo.new
      info[:broadcast] = broadcast_callback
      info[:device] = device_callback
      info[:service] = service_callback

      result = Lxi.lxi_discover_internal(info, timeout, type)
      raise(Error, "Discovery error: #{result}") unless result == LXI_OK

      sleep(0.5)
      @devices
    end

    # Discover LXI-11 devices on the LAN
    def discover(timeout: 1000, type: :vxi11)
      Lxi.init_lxi_session

      info = FFIFunctions::LxiInfo.new
      info[:broadcast] = BroadcastCallback
      info[:device] = DeviceCallback

      puts("Searching for LXI devices - please wait...\n\n")

      result = lxi_discover_internal(info, timeout, type)

      puts("Error during discovery: #{result}") if result.negative?
    end

    private

    def broadcast_callback
      FFI::Function.new(:void, %i[pointer pointer]) do |service, interface|
        puts("Broadcast: #{service.read_string} on #{interface.read_string}\n\n")
        # @devices << { service: service.read_string, interface: interface.read_string }
      end
    end

    def device_callback
      FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
        puts("Device: #{id.read_string} at #{address.read_string}")
        # @devices << { address: address.read_string, id: id.read_string, service: service.read_string, port: port }
      end
    end

    def service_callback
      FFI::Function.new(:void, %i[pointer pointer pointer int]) do |address, id, service, port|
        puts(
          "    Found: #{id.read_string} at #{address.read_string}\n        #{service.read_string} service on port: #{port}"
        )
        # @devices << { address: address.read_string, id: id.read_string, service: service.read_string, port: port }
      end
    end
  end
end
