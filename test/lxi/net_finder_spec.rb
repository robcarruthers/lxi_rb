# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../../lib/lxi_rb'

describe Lxi::NetFinder do
  before { Lxi.stub(:init, 0) { @net_finder = Lxi::NetFinder.new } }

  describe '#search' do
    it 'returns an array' do
      Lxi::LibChecker.stub(:installed?, true) do
        expect(@net_finder.search(timeout: 5, type: :vxi11)).must_be_instance_of(Array)
      end
    end

    it 'raises an error if mDNS library not found' do
      Lxi::LibChecker.stub(:installed?, false) do
        _ { @net_finder.search(timeout: 250, type: :mdns) }.must_raise(Lxi::Error)
      end
    end
  end
end
