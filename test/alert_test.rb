#!/usr/bin/env ruby

require_relative 'test_helper'

# Test class for Minitest Unit Tests
class AlertTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil VERSION
  end

  def test_alarm
    Alert.new message: 'Alarm', level: :alarm, config: Config.new('test/test.config')
  end

  def test_info
    Alert.new message: 'Info', level: :info
  end
end
