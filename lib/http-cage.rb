require 'http-cage/version'
require 'http-cage/patch'
require 'net/http'

module HTTPCage
  @connection = 60
  @request = 60

  def self.connection
    @connection
  end

  def self.request
    @request
  end

  def self.timeout(args)
    @connection = args[:connection]
    @request = args[:request]
    apply
  end

  def self.apply
    Net::HTTP.prepend HTTPCage::Patch
  end
end
