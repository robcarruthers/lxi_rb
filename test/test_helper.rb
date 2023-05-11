# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'lxi_rb'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use! [MiniTest::Reporters::DefaultReporter.new(color: true)]
