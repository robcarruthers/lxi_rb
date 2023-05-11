require 'minitest/autorun'
require_relative '../../lib/lxi_rb' # Adjust relative path to the file containing the Lxi module as needed
require 'test_helper'

describe Lxi do
  describe '#init_lxi_session' do
    it 'returns an Lxi::Error when init fails' do
      Lxi.stub :lxi_init, Lxi::LXI_ERROR do
        expect { Lxi.init_lxi_session }.must_raise Lxi::Error
      end
    end
  end

  describe '#Lxi.discover' do
    it 'returns an array' do
      Lxi.stub :lxi_discover_internal, Lxi::LXI_OK do
        result = Lxi.discover
        expect(result).must_be_instance_of Array
      end
    end
  end
end
