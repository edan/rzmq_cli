require 'simplecov'
require 'minitest'
require 'minitest/autorun'

require './lib/rzmq_cli/runner'

class RzmqCliRunner < Minitest::Test

  def test_initialize_runner
    runner_args = {
      "mode"           => :bind,
      "addresses"      => ["tcp://0.0.0.0:7777"],
      "socket_type"    => "PUSH",
    }

    rzmq_cli_runner = RzmqCli::Runner.new(runner_args)

    assert rzmq_cli_runner.mode
    assert rzmq_cli_runner.socket_type
    assert rzmq_cli_runner.addresses
    assert rzmq_cli_runner.zmq_context

    assert_nil rzmq_cli_runner.socket_options
  end
end
