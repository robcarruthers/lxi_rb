# frozen_string_literal: true
require 'ffi'

module Lxi
  include FFI
  # VXI11 Discovery Callbacks
  BroadcastCallback =
    FFI::Function.new(:void, %i[pointer pointer]) do |address, interface|
      puts("Broadcast: #{address.read_string}, #{interface.read_string}")
    end

  DeviceCallback =
    FFI::Function.new(:void, %i[pointer pointer]) do |address, id|
      puts("Device: #{address.read_string}, #{id.read_string}")
    end

  ServiceCallback =
    FFI::Function.new(:void, %i[pointer pointer pointer int]) do |address, id, service, port|
      puts("Service: #{address.read_string}, #{id.read_string}, #{service.read_string}, #{port}")
    end
end
