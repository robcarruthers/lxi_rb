# frozen_string_literal: true

module Lxi
  # Initialise the LXI library
  def self.init_session
    raise(Error, 'LXI Library not found') unless LibChecker.installed?(LIBLXI_PATHS)
    raise(Error, 'LXI Library Initialisation Error') unless Lxi.init == LXI_OK

    true
  end

  module LibChecker
    extend FFI::Library

    def self.installed?(lib_paths = [])
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
