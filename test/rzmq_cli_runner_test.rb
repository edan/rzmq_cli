require 'simplecov'
require 'minitest'
require 'minitest/autorun'
require 'debugger'

require './lib/rzmq_cli/runner'

class RzmqCliRunnerTest < Minitest::Test

  def test_initialize_runner
    runner_args = {
      "mode"           => :bind,
      "addresses"      => ["tcp://0.0.0.0:7777"],
      "socket_type"    => "PUSH",
    }

    rcr = RzmqCli::Runner.new(runner_args)

    assert rcr.mode
    assert rcr.socket_type
    assert rcr.addresses
    assert rcr.zmq_context

    assert_nil rcr.socket_options
  end


  def test_socket_types
    socket_types = {
      'PULL' => ZMQ::PULL,
      'PUSH' => ZMQ::PUSH,
      'PUB'  => ZMQ::PUB,
      'SUB'  => ZMQ::SUB,
      'REQ'  => ZMQ::REQ,
      'REP'  => ZMQ::REP,
      'PAIR' => ZMQ::PAIR
    }

    socket_types.keys.each do |socket_type_arg|
      rcr = RzmqCli::Runner.new("socket_type" => socket_type_arg)
      assert_equal socket_types[socket_type_arg], rcr.socket_type
    end

    rcr = RzmqCli::Runner.new("socket_type" => "something_not_in_list")
    assert_nil rcr.socket_type #TODO should raise
  end

  def test_set_up_socket
    runner_args = {
      "mode"           => :bind,
      "addresses"      => ["tcp://0.0.0.0:7777"],
      "socket_type"    => "PUSH",
    }

    rcr = RzmqCli::Runner.new(runner_args)

    mock_socket = Minitest::Mock.new
    mock_socket.expect(:bind, :return_value, ["tcp://0.0.0.0:7777"])

    rcr.zmq_context.stub :socket, mock_socket do
      rcr.set_up_socket!
      mock_socket.verify
    end

  end
end
