module Lxi
  module LxiMethods
    private

    # Initialise the LXI library
    def init_lxi_session
      raise Error, 'LXI Library Initialisation Error' unless Lxi.lxi_init == LXI_OK
    end
  end
end
