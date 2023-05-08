# frozen_string_literal: true

require_relative 'lxi/version'
require_relative 'lxi/functions'
require_relative 'lxi/methods'
require_relative 'lxi/constants'
require_relative 'lxi/callbacks'
require_relative 'lxi/discovery'
require_relative 'lxi/device'

module Lxi
  extend FFIFunctions

  class Error < StandardError
  end
end
