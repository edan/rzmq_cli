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

    def initialize(args)
      @mode           = args["mode"]
      @addresses      = args["addresses"]

      @socket_type    = VALID_ZMQ_SOCKET_TYPES[args["socket_type"]]
      @socket_options = args["socket_options"]
      @input          = args["input"]  || $stdin
      @logger         = args["logger"] || $stderr

      @zmq_context    = ZMQ::Context.new
    end

    def set_up_socket!
      @socket = zmq_context.socket(socket_type)
      @logger.puts "is #{mode}"
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
      @logger.puts "PUSH socket starting"

      write
    end

    def pull_loop(socket)
      @logger.puts "PULL socket starting"

      read_loop
    end

    def read_loop
      @logger.puts "reading from #{addresses}"

      msg = ''
      loop do
        socket.recv_string(msg)
        @logger.puts msg
      end
    end

    def write
      @logger.puts "writing to #{addresses}"

      socket.send_string(@input.gets)
    end
  end
end
