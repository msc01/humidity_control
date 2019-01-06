#!/usr/bin/env ruby

require_relative 'test_helper'

# Test class for Minitest Unit Tests
class SensorTest < Minitest::Test
  def setup
    # ...
  end

  def mountebank
    # Assumes that [Mountebank][http://www.mbtest.org] is up an running
    # TODO: Include Mountebank dependency
    # ---
    # First, delete any old imposters
    mountebank_delete

    # Then, setup imposter needed for testing
    mountebank_setup
  rescue StandardError => exception
    puts exception
  end

  def mountebank_delete
    HTTParty.delete('http://localhost:2525/imposters/1000')
  end

  def mountebank_setup
    body = <<-HEREDOC
    {"port": 1000, "protocol": "http", "name": "ESP32-FC37", "stubs": [{"predicates": [{"equals": {"method": "GET", "path": "/"}}], "responses": [{"is": {"statusCode": 200, "headers": {"Content-Type": "application/json"}, "body": {"ESP32": {"status": {"uptime": "1", "LED_builtin": "off"}, "sensor": {"type": "FC37", "value": "4095", "interpretation": "dry"}}}}}]}]}
    HEREDOC

    HTTParty.post('http://localhost:2525/imposters/', body: body, headers: { 'Content-Type' => 'application/json' })
  end

  def test_that_it_has_a_version_number
    refute_nil VERSION
  end

  def test_that_sensor_has_a_reading
    mountebank
    sensor = Sensor.new(config: Config.new('test/humidity_control_test.config'))
    refute_nil sensor.reading
  end

  def test_that_sensor_is_dry
    mountebank
    sensor = Sensor.new(config: Config.new('test/humidity_control_test.config'))
    assert_equal 'dry', sensor.reading
  end

  def test_that_rescuing_works
    mountebank_delete
    sensor = Sensor.new(config: Config.new('test/humidity_control_test.config'))
    assert_raises(StandardError) { sensor.reading }
  end
end
