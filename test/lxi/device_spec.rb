# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../../lib/lxi_rb'

describe Lxi::Device do
  before { Lxi.stub(:connect, 0) { @device = Lxi::Device.new('127.0.0.1', :vxi11) } }

  describe '#write' do
    it 'raises an error if send fails' do
      message = 'test string'
      Lxi.stub(:__send, -1) { _ { @device.write(message) }.must_raise Lxi::Error }
    end

    it 'returns number of bytes sent if send succeeds' do
      message = 'test string'
      Lxi.stub(:__send, message.length) { expect(@device.write(message)).must_equal(message.length) }
    end
  end

  describe '#read' do
    it 'raises an error if read fails' do
      Lxi.stub(:receive, -1) { _ { @device.read(10) }.must_raise(Lxi::Error) }
    end

    it 'returns message if read succeeds' do
      message = FFI::MemoryPointer.new(:char, 10)
      Lxi.stub(:receive, 10) { expect(@device.read(10)).must_equal(message.read_string) }
    end
  end

  describe '#disconnect' do
    it 'calls lxi_disconnect with correct id' do
      Lxi.stub(:disconnect, @device.id) do
        id = @device.id
        expect(@device.disconnect).must_equal(id)
      end
    end
  end
end
