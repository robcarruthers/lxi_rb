# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../../lib/lxi_rb'

describe Lxi do
  describe '#init_session' do
    it 'returns an Lxi::Error when init fails' do
      Lxi.stub(:init, Lxi::LXI_ERROR) { expect { Lxi.init_session }.must_raise(Lxi::Error) }
    end
  end
end
