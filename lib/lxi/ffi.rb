require 'ffi'

module Lxi
  extend FFI::Library

  # Set the path to the library
  ffi_lib '/opt/homebrew/lib/liblxi.dylib'
  ffi_lib_flags :now, :global

  # Expose liblxi functions
  attach_function :lxi_init, [], :int
  attach_function :lxi_discover_internal, :lxi_discover, [LxiInfo.ptr, :int, :lxi_discover_type], :int
  attach_function :lxi_discover_if, [LxiInfo.ptr, :string, :int, :lxi_discover_type], :int
  attach_function :lxi_connect, %i[string int string int lxi_protocol_type], :int
  attach_function :lxi_send, %i[int string int int], :int
  attach_function :lxi_receive, %i[int pointer int int], :int
  attach_function :lxi_disconnect, [:int], :int

  # LXI Constants
  LXI_OK = 0
  LXI_ERROR = -1

  # Define liblxi enums
  enum :lxi_protocol_type, %i[vxi11 raw hyslip]
  enum :lxi_discover_type, %i[vxi11 mdns]

  # VXI11 Discovery Callbacks
  BroadcastCallback =
    FFI::Function.new(:void, %i[pointer pointer]) do |address, interface|
      puts "Broadcast: #{address.read_string}, #{interface.read_string}"
    end

  DeviceCallback =
    FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
      puts "Device: #{address.read_string}, #{id.read_string}"
    end

  ServiceCallback =
    FFI::Function.new(:void, %i[pointer pointer pointer int]) do |address, id, service, port|
      puts "Service: #{address.read_string}, #{id.read_string}, #{service.read_string}, #{port}"
    end

  # Define liblxi structs
  class LxiInfo < FFI::Struct
    layout :broadcast,
           callback(%i[pointer pointer], :void),
           :device,
           callback(%i[pointer pointer], :void),
           :service,
           callback(%i[pointer pointer pointer int], :void)
  end

  # Discover LXI-11 devices on the LAN
  def self.search(timeout: 1000, type: :vxi11)
    lxi_init

    info = LxiInfo.new
    info[:broadcast] = BroadcastCallback
    info[:device] = DeviceCallback

    puts "Searching for LXI devices - please wait...\n\n"

    result = lxi_discover_internal(info, timeout, type)

    puts "Error during discovery: #{result}" if result < 0
  end
end
