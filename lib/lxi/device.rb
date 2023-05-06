module Lxi
  class Device
    include FFI
    attr_accessor :id, :address, :port, :name, :timeout, :protocol

    def initialize(address, protocol)
      @address = address
      @port = 0
      @name = nil
      @timeout = 1000
      @protocol = protocol
      @id = -1

      connect
    end

    def connect
      @id = Lxi.lxi_connect(@address, @port, @name, @timeout, @protocol)
      @id
    end

    def disconnect
      Lxi.lxi_disconnect(@device_id)
    end

    def send_scpi(message)
      Lxi.lxi_send(@device_id, message, message.length, @timeout)
    end

    def read(length)
      message = FFI::MemoryPointer.new(:char, length)
      Lxi.lxi_receive(@id, message, length, @timeout)
      message.read_string
    end
  end
end
