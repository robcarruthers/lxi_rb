# frozen_string_literal: true

require_relative 'lxi/version'
require_relative 'lxi/ffi_functions'
require_relative 'lxi/lxi_methods'
require_relative 'lxi/lxi_constants'
require_relative 'lxi/device'

module Lxi
  extend FFIFunctions
  include LxiMethods

  class Error < StandardError
  end
end
