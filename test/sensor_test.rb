#!/usr/bin/env ruby

require_relative 'test_helper'

# Test class for Minitest Unit Tests
class SensorTest < Minitest::Test
  def setup
    @sensor = Sensor.new
  end

  def test_that_it_has_a_version_number
    refute_nil VERSION
  end

  def test_that_url_matches
    assert_equal 'http://192.168.178.222', @sensor.url
  end

  def test_that_sensor_has_a_reading
    refute_nil @sensor.reading
  end

  def test_that_sensor_is_dry
    assert_equal 'dry', @sensor.reading
  end
end
