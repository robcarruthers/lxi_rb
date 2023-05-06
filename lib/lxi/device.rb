module Lxi
  class Device
    include FFI
    attr_reader :device_id, :address, :port, :name, :timeout, :protocol

    def initialize(address, port, name, timeout, protocol)
      @address = address
      @port = port
      @name = name
      @timeout = timeout
      @protocol = protocol
      @device_id = -1
    end

    def test
      puts 'Testing!'
    end

    def connect
      @device_id = Lxi.lxi_connect(@address, @port, @name, @timeout, :VXI11)
      @device_id
    end

    def disconnect
      Lxi.lxi_disconnect(@device_id)
    end

    def send_message(message)
      Lxi.lxi_send(@device_id, message, message.length, @timeout)
    end

    def receive_message(length)
      message = FFI::MemoryPointer.new(:char, length)
      Lxi.lxi_receive(@device_id, message, length, @timeout)
      message.read_string
    end
  end
end
