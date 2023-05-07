# frozen_string_literal: true
require 'ffi'

module Lxi
  extend FFI::Library

  ffi_lib '/opt/homebrew/lib/liblxi.dylib'
  ffi_lib_flags :now, :global

  # Define liblxi structs
  class LxiInfo < FFI::Struct
    layout :broadcast,
           callback(%i[pointer pointer], :void),
           :device,
           callback(%i[pointer pointer], :void),
           :service,
           callback(%i[pointer pointer pointer int], :void)
  end

  # LXI Constants
  LXI_OK = 0
  LXI_ERROR = -1

  # Define liblxi enums
  enum :lxi_protocol_type, %i[vxi11 raw hyslip]
  enum :lxi_discover_type, %i[vxi11 mdns]

  # Expose liblxi functions
  attach_function :lxi_init, [], :int
  attach_function :lxi_discover_internal, :lxi_discover, [LxiInfo.ptr, :int, :lxi_discover_type], :int
  attach_function :lxi_discover_if, [LxiInfo.ptr, :string, :int, :lxi_discover_type], :int
  attach_function :lxi_connect, %i[string int string int lxi_protocol_type], :int
  attach_function :lxi_send, %i[int string int int], :int
  attach_function :lxi_receive, %i[int pointer int int], :int
  attach_function :lxi_disconnect, [:int], :int

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

  # Initialise the LXI library
  def init_lxi_session
    raise Error, 'LXI Library Initialisation Error' unless lxi_init == LXI_OK
  end

  # Search for LXI-11 devices on the specified interface and return hash of devices
  def self.devices(timeout: 1000, type: :vxi11)
    raise Error, 'LXI Library Initialisation Error' unless lxi_init == LXI_OK

    devices = []
    callback =
      FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
        devices << { address: address.read_string, id: id.read_string }
      end

    info = LxiInfo.new
    info[:broadcast] = BroadcastCallback
    info[:device] = callback

    lxi_discover_internal(info, timeout, type)
    sleep 0.1
    devices
  end

  # Discover LXI-11 devices on the LAN
  def self.discover_local(timeout: 1000, type: :vxi11)
    init_lxi_session

    info = LxiInfo.new
    info[:broadcast] = BroadcastCallback
    info[:device] = DeviceCallback

    puts "Searching for LXI devices - please wait...\n\n"

    result = lxi_discover_internal(info, timeout, type)

    puts "Error during discovery: #{result}" if result.negative?
  end
end
