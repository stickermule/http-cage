require 'http-cage/version'
require 'http-cage/patch'
require 'net/http'

module HTTPCage
  @connection = 60
  @request = 60
  @ssl = 60

  def self.connection
    @connection
  end

  def self.request
    @request
  end

  def self.ssl
    @ssl
  end

  def self.timeout(args)
    @connection = args[:connection]
    @request = args[:request]
    @ssl = args[:ssl]
    apply
  end

  def self.apply
    Net::HTTP.prepend HTTPCage::Patch
  end
end
