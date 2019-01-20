#!/usr/bin/env ruby

require_relative 'test_helper'

# === Test class for Minitest Unit Tests
class SensorTest < Minitest::Test
  include Mountebank

  # --- Actual Tests
  def test_that_it_has_a_version_number
    refute_nil VERSION
  end

  def test_that_stub_http_response_matches_interface
    expected_http_response = JSON.parse <<~HEREDOC
      {"ESP32": {"status": {"uptime": "1", "LED_builtin": "off"}, "sensor": {"type": "FC37", "value": "4095", "interpretation": "dry"}}}
    HEREDOC
    mountebank
    actual_response = Sensor.new(config: Config.new('test/test.config')).response.parsed_response

    assert_equal expected_http_response, actual_response
  end

  def test_that_stub_sensor_has_a_reading
    mountebank
    sensor = Sensor.new(config: Config.new('test/test.config'))
    sensor.read

    refute_nil sensor.reading
  end

  def test_that_stub_sensor_data_is_right
    mountebank
    sensor = Sensor.new(config: Config.new('test/test.config'))
    sensor.read

    assert_equal 'FC37', sensor.type
    assert_equal '1', sensor.uptime
    assert_equal 'off', sensor.builtin_led
    assert_equal '4095', sensor.value
    assert_equal 'dry', sensor.reading
  end

  def test_that_rescuing_works
    mountebank_delete
    sensor = Sensor.new(config: Config.new('test/test.config'))

    assert_raises(StandardError) { sensor.read }
  end

  def test_new_day
    mountebank
    sensor = Sensor.new(config: Config.new('test/test.config'))

    assert_equal false, sensor.new_day?
    
  end
end
