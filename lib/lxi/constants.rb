# frozen_string_literal: true
module Lxi
  # LXI Constants
  LXI_OK = 0
  LXI_ERROR = -1

  LIBLXI_PATHS = %w[
    liblxi
    liblxi.so.1
    /home/linuxbrew/.linuxbrew/lib/liblxi.so.1
    /usr/local/lib/liblxi.dylib
    /usr/local/lib/liblxi.so
    /usr/lib/liblxi.dylib
    /usr/lib/liblxi.so
  ].freeze

  MDNS_PATHS = %w[
    mdns
    avahi-client
    libavahi-client
    avahi-client.so.1
    /home/linuxbrew/.linuxbrew/lib/avahi-client.so.1
    /usr/local/lib/libavahi-client.so
    /usr/lib/libavahi-client.so
  ].freeze
end
