require 'net/http'
require 'http-cage'
require 'colorize'

# Client making a 10 seconds HTTP call.
class SlowCall
  def get
    request = "http request: "
    begin
      sleep 0.5
      puts request + "started".yellow
      http = Net::HTTP.new('httpbin.org')
      get = Net::HTTP::Get.new('/delay/10')
      http.request(get).body
      puts request + "completed".green
    rescue Net::ReadTimeout
      puts request + "timed out".red
    rescue Net::OpenTimeout
      puts request + "timed out".red
    rescue Interrupt
      puts request + "shutdown".green
    end
  end
end

# Server running with a timeout of 5 seconds.
class Server
  def run
    server = "server: "
    trap("INT") do
      puts server + "shutdown".green
      exit
    end

    puts server + "booting".green
    loop do
      worker = fork do
        SlowCall.new().get
      end

      begin
        Timeout.timeout(10) do
          puts server + "ready".yellow
          Process.wait worker
          next
        end
      rescue Timeout::Error
        puts server + "down".red
        Process.kill("INT", worker)
        Process.wait(worker)
        break
      end
    end
  end
end
