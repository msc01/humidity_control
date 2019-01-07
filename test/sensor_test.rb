#!/usr/bin/env ruby

require_relative 'test_helper'

# Test class for Minitest Unit Tests
class SensorTest < Minitest::Test
  MOUNTEBANK_ADDRESS = 'http://localhost:2525/imposters/'.freeze

  def mountebank
    # Assumes that [Mountebank][http://www.mbtest.org] is up an running
    # ---
    # First, delete any old imposters
    mountebank_delete

    # Then, setup imposter needed for testing
    mountebank_setup
  end

  def mountebank_delete
    HTTParty.delete(MOUNTEBANK_ADDRESS)
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't delete from Mountebank@#{MOUNTEBANK_ADDRESS}!\n#{errormsg}"
    raise
  end

  def mountebank_setup
    body = <<~HEREDOC
      {"port": 1000, "protocol": "http", "name": "ESP32-FC37", "stubs": [{"predicates": [{"equals": {"method": "GET", "path": "/"}}], "responses": [{"is": {"statusCode": 200, "headers": {"Content-Type": "application/json"}, "body": {"ESP32": {"status": {"uptime": "1", "LED_builtin": "off"}, "sensor": {"type": "FC37", "value": "4095", "interpretation": "dry"}}}}}]}]}
    HEREDOC

    HTTParty.post(MOUNTEBANK_ADDRESS, body: body, headers: { 'Content-Type' => 'application/json' })
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't post to Mountebank@#{MOUNTEBANK_ADDRESS}!\n#{errormsg}"
    raise
  end

  def test_that_it_has_a_version_number
    refute_nil VERSION
  end

  def test_that_stub_http_response_matches_interface
    http_response = <<~HEREDOC
      '{"ESP32": {"status": {"uptime": "1", "LED_builtin": "off"}, "sensor": {"type": "FC37", "value": "4095", "interpretation": "dry"}}}'
    HEREDOC
    mountebank
    sensor = Sensor.new(config: Config.new('test/humidity_control_test.config'))
    assert_equal http_response, sensor.response
  end

  def test_that_stub_sensor_has_a_reading
    mountebank
    sensor = Sensor.new(config: Config.new('test/humidity_control_test.config'))
    refute_nil sensor.reading
  end

  def test_that_stub_sensor_is_dry
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
