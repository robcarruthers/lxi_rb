# frozen_string_literal: true
module Lxi
  # Initialise the LXI library
  def self.init_lxi_session
    raise Error, 'LXI Library Initialisation Error' unless Lxi.lxi_init == LXI_OK
  end
end
