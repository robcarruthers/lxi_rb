# frozen_string_literal: true

module Lxi
  class NetFinder
    include FFI

    def init
      @devices = []
      Lxi.init_session
    end

    def search(type = :vxi11, timeout: 1000)
      if type == :vxi11
        search_vxi11(timeout)
      elsif type == :mdns
        search_mdns(timeout)
      else
        raise Error, 'Invalid search type'
      end
    end

    private

    def search_vxi11(timeout)
      net_search(timeout, :vxi11)
    end

    def search_mdns(timeout)
      raise Error, 'mDNS library not found' unless mdns_lib_found?
      net_search(timeout, :mdns)
    end

    def net_search(timeout, type)
      @devices = []
      info = FFIFunctions::LxiInfo.new
      info[:broadcast] = broadcast_callback
      info[:device] = device_callback
      info[:service] = service_callback

      result = Lxi.discover(info, timeout, type)
      raise Error, "Discovery error: #{result}" unless result == LXI_OK

      sleep(0.25)
      @devices
    end

    def mdns_lib_found?
      Lxi::LibChecker.installed?(Lxi::MDNS_LIBS)
    end

    def broadcast_callback
      FFI::Function.new(:void, %i[pointer pointer]) do |service, interface|
        # puts("Broadcast: #{service.read_string} on #{interface.read_string}\n\n")
        # @devices << { service: service.read_string, interface: interface.read_string }
      end
    end

    def device_callback
      FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
        # puts("Device: #{id.read_string} at #{address.read_string}")
        @devices << { address: address.read_string, id: id.read_string }
      end
    end

    def service_callback
      FFI::Function.new(:void, %i[pointer pointer pointer int]) do |address, id, service, port|
        address = address.read_string
        id = id.read_string
        service = service.read_string
        @devices << { address:, id:, service:, port: }
      end
    end
  end
end
