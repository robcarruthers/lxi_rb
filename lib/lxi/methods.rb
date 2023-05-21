# frozen_string_literal: true

module Lxi
  # Initialise the LXI library
  def self.init_lxi_session
    raise(Error, 'LXI Library Initialisation Error') unless Lxi.init == LXI_OK
  end

  module LibChecker
    extend FFI::Library

    def self.installed?(lib_name, lib_paths = [])
      lib_paths.unshift(lib_name)
      lib_paths.each do |path|
        begin
          ffi_lib path
          return true
        rescue LoadError
          next
        end
      end
      false
    end
  end
end
