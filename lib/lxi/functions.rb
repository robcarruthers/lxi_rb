# frozen_string_literal: true
require 'ffi'

module Lxi
  module FFIFunctions
    extend FFI::Library

    ffi_lib %w[liblxi liblxi.so.1 /home/linuxbrew/.linuxbrew/lib/liblxi.so.1]
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

    # Define liblxi enums
    enum :lxi_protocol_type, %i[vxi11 raw hyslip]
    enum :lxi_discover_type, %i[vxi11 mdns]

    # Expose liblxi functions
    attach_function :init, :lxi_init, [], :int
    attach_function :discover, :lxi_discover, [LxiInfo.ptr, :int, :lxi_discover_type], :int
    attach_function :discover_if, :lxi_discover_if, [LxiInfo.ptr, :string, :int, :lxi_discover_type], :int
    attach_function :connect, :lxi_connect, %i[string int string int lxi_protocol_type], :int
    attach_function :send, :lxi_send, %i[int string int int], :int
    attach_function :recieve, :lxi_receive, %i[int pointer int int], :int
    attach_function :disconnect, :lxi_disconnect, [:int], :int
  end
end
