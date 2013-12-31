#!/usr/bin/env ruby
require 'docopt'
require 'rzmq_cli'

doc = <<DOCOPT
Usage:
  #{__FILE__} rzmq-cli (-b | -c) SOCKET_TYPE <address>... 
  #{__FILE__} rzmq-cli (-b | -c) SOCKET_TYPE [-o SOCKET_OPTIONS...] <address>... 
DOCOPT

begin
  args = Docopt::docopt(doc)
rescue Docopt::Exit => e
  puts e.message
  exit(0)
end

RzmqCli::Runner.new(args).run
