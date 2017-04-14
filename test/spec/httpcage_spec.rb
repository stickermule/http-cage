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

  it 'can be overridden by another cage' do
    HTTPCage.timeout(connection: 10, request: 20)
    client = Net::HTTP.new('google.com')
    client.open_timeout.must_equal 10
    client.read_timeout.must_equal 20
  end

  it 'will not timeout on a routable address' do
    client = Net::HTTP.new('httpbin.org')
    get = Net::HTTP::Get.new('/')
    client.request(get).code.must_equal "200"
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
