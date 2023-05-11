require 'minitest/autorun'
require_relative '../../lib/lxi_rb' # Adjust relative path to the file containing the Lxi module as needed

describe Lxi::Device do
  before do
    Lxi.stub :lxi_connect, 0 do
      @device = Lxi::Device.new('127.0.0.1', :vxi11)
    end
  end

  describe '#send' do
    it 'raises an error if send fails' do
      Lxi.stub :lxi_send, -1 do
        _ { @device.send('message') }.must_raise Lxi::Error
      end
    end

    it 'returns number of bytes sent if send succeeds' do
      message = 'test string'
      Lxi.stub :lxi_send, message.length do
        _(@device.send('message')).must_equal message.length
      end
    end
  end

  describe '#read' do
    it 'raises an error if read fails' do
      Lxi.stub :lxi_receive, -1 do
        _ { @device.read(10) }.must_raise Lxi::Error
      end
    end

    it 'returns message if read succeeds' do
      message = FFI::MemoryPointer.new(:char, 10)
      Lxi.stub :lxi_receive, 1 do
        _(@device.read(10)).must_equal message.read_string
      end
    end
  end

  describe '#disconnect' do
    it 'calls lxi_disconnect with correct id' do
      Lxi.stub :lxi_disconnect, @device.id do
        id = @device.id
        expect(@device.disconnect).must_equal id
      end
    end
  end
end
