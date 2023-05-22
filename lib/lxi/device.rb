# frozen_string_literal: true

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

      yield(self) if block_given?
    end

    def connect
      Lxi.init_session

      @id = Lxi.connect(@address, @port, @name, @timeout, @protocol)
      ap @id
      raise(Error, 'LXI Connection Error') if @id == LXI_ERROR

      true
    end
    alias open connect

    def disconnect
      Lxi.disconnect(@id)
    end
    alias close disconnect

    def write(message)
      bytes_sent = Lxi.send(@id, message, message.length, @timeout)
      raise(Error, 'LXI communications error') unless bytes_sent.positive?

      bytes_sent
    end
    alias scpi write
    alias send write

    def read(length)
      message = FFI::MemoryPointer.new(:char, length)
      bytes_received = Lxi.receive(@id, message, length, @timeout)
      raise(Error, 'LXI communications error') unless bytes_received.positive?

      message.read_string
    end
    alias gets read

    def query(message)
      write(message)
      read(10_000)
    end
  end
end
