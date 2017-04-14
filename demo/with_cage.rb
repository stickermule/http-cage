#! /usr/bin/ruby
# With http-cage the server
# will stay up

require_relative 'example'

HTTPCage.timeout(connection: 1, request: 1)
Server.new().run
