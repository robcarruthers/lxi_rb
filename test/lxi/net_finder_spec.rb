# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../../lib/lxi_rb'

describe Lxi::NetFinder do
  before { Lxi.stub(:init, 0) { @net_finder = Lxi::NetFinder.new } }

  describe '#search' do
    it 'raises an error if invalid search type' do
      expect { @net_finder.search :invalid }.must_raise(Lxi::Error)
    end

    it 'returns an array' do
      Lxi::LibChecker.stub(:installed?, true) { expect(@net_finder.search).must_be_instance_of(Array) }
    end

    it 'raises an error if mDNS library not found' do
      Lxi::LibChecker.stub(:installed?, false) { _ { @net_finder.search :mdns }.must_raise(Lxi::Error) }
    end
  end
end
