#!/usr/bin/env ruby

require_relative 'test_helper'

# Test class for Minitest Unit Tests
class DurationTest < Minitest::Test
  include Duration

  def test_duration
    assert_equal '1 d 1:1:1', beautify(90_061)
  end
end
