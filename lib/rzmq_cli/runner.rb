require 'ffi-rzmq'

module RzmqCli
  class Runner
    VALID_ZMQ_SOCKET_TYPES = {
      'PULL' => ZMQ::PULL,
      'PUSH' => ZMQ::PUSH,
      'PUB'  => ZMQ::PUB,
      'SUB'  => ZMQ::SUB,
      'REQ'  => ZMQ::REQ,
      'REP'  => ZMQ::REP,
      'PAIR' => ZMQ::PAIR
    }

    attr_reader   :zmq_context
    attr_accessor :mode, :socket_type, :socket_options, :socket, :addresses

    def initialize(args, output = nil)
      @mode           = args["-b"] ? :bind : :connect #relies on mutual exclusive options
      @addresses      = args["<address>"]

      @socket_type    = VALID_ZMQ_SOCKET_TYPES[args["SOCKET_TYPE"]]
      @socket_options = args["-o"]

      @zmq_context    = ZMQ::Context.new
    end

    def set_up_socket!
      @socket = zmq_context.socket(socket_type)
      puts "is #{mode}"
      addresses.each{|a| @socket.__send__(@mode, a)}
    end

    def run
      set_up_socket!

      case socket_type
      when ZMQ::PUSH
        push_loop(socket)
      when ZMQ::PULL
        pull_loop(socket)
      end
    end

    def push_loop(socket)
      puts "PUSH socket starting"

      write
    end

    def pull_loop(socket)
      puts "PULL socket starting"

      read_loop
    end

    def read_loop
      puts "reading from #{addresses}"

      msg = ''
      loop do
        socket.recv_string(msg)
        puts msg
      end
    end

    def write
      puts "writing to #{addresses}"

      socket.send_string($stdin.gets)
    end
  end
end
