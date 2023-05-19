# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../../lib/lxi_rb'
require 'test_helper'

class LxiSpec < Minitest::Spec
  describe '#init_lxi_session' do
    it 'returns an Lxi::Error when init fails' do
      Lxi.stub(:lxi_init, Lxi::LXI_ERROR) { expect { Lxi.init_lxi_session }.must_raise(Lxi::Error) }
    end
  end

  describe '#Lxi.search' do
    it 'returns an array' do
      Lxi.stub(:lxi_discover_internal, Lxi::LXI_OK) do
        result = Lxi.search
        expect(result).must_be_instance_of(Array)
      end
    end
  end
end
