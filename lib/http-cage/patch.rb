require 'net/http'

module HTTPCage
  module Patch
    def initialize(*args, &block)
      super(*args, &block)
      self.open_timeout = HTTPCage.connection
      self.read_timeout = HTTPCage.request
    end
  end
end
