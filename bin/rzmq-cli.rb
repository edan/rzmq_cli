#!/usr/bin/env ruby
require 'docopt'
require 'rzmq_cli'

doc = <<DOCOPT
Usage:
  #{__FILE__} rzmq-cli (-b | -c) SOCKET_TYPE <address>... 
  #{__FILE__} rzmq-cli (-b | -c) SOCKET_TYPE [-o SOCKET_OPTIONS...] <address>... 
DOCOPT

begin
  options = Docopt::docopt(doc)

  args = {
    "mode"           => options["-b"] ? :bind : :connect,
    "addresses"      => options["<address>"],
    "socket_type"    => options["SOCKET_TYPE"],
    "socket_options" => options["-o"]
  }

  RzmqCli::Runner.new(args).run
rescue Docopt::Exit => e
  puts e.message
  exit(0)
end
