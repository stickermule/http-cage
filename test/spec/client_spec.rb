require_relative '_init'
require 'net/http'
require 'uri'

describe 'HTTPCage' do
  before do
    HTTPCage.timeout(connection: 1, request: 2)
  end

  it 'overrides Net::HTTP timeouts' do
    client = Net::HTTP.new('google.com')
    client.open_timeout.must_equal 1
    client.read_timeout.must_equal 2
  end

  it 'will not timeout on a routable address' do
    client = Net::HTTP.new('www.google.com')
    get = Net::HTTP::Get.new('/')
    client.request(get).body.strip.must_include "Moved"
  end

  it 'will timeout during connection on a non-routable address' do
    client = Net::HTTP.new('10.255.255.1')
    get = Net::HTTP::Get.new('/')
    proc { client.request(get).body }.must_raise Net::OpenTimeout
  end

  it 'will timeout during request on a slow responding address' do
    uri = URI.parse('https://httpbin.org/delay/10')
    client = Net::HTTP.new(uri.host, uri.port)
    get = Net::HTTP::Get.new(uri.request_uri)
    proc { client.request(get).body }.must_raise Net::ReadTimeout
  end
end
