require 'net/http'
require 'http-cage'
require 'colorize'

# Client making a 10 seconds HTTP call.
class SlowCall
  def get
    begin
      p "Starting http call"
      http = Net::HTTP.new('httpbin.org')
      get = Net::HTTP::Get.new('/delay/10')
      http.request(get).body
      p "http completed"
    rescue Net::ReadTimeout
      p "http timed out"
    rescue Net::OpenTimeout
      p "http timed out"
    rescue Interrupt
      p "http killed"
    end
  end
end

# Server running with a timeout of 5 seconds.
class Server
  def run
    trap("INT") do
      p "manual shut down"
      exit
    end

    p "booting server"
    loop do
      worker = fork do
        SlowCall.new().get
      end

      begin
        Timeout.timeout(10) do
          p "server process waiting"
          Process.wait worker
          next
        end
      rescue Timeout::Error
        p "server going down"
        Process.kill('INT', worker)
        break
      end
    end
  end
end
