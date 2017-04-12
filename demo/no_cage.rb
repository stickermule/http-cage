#! /usr/bin/ruby
# Without http-cage a timeout
# will kill the server

require_relative 'example'

Server.new().run
