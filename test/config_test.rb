require_relative 'test_helper'

# Test class for Minitest Unit Tests
class ConfigTest < Minitest::Test
  def test_that_instance_is_of_right_class
    config = Config.new
    assert config.instance_of?(Config)
  end

  def test_that_it_works_with_default_config_file
    ENV['HUMIDITY-CONTROL_CONFIG_FILE'] = nil
    config = Config.new
    assert config.instance_of?(Config)
  end

  def test_that_it_does_not_work_without_a_config_file
    assert_raises(Errno::ENOENT) { Config.new('data/humidity_control_test.not_config') }
  end

  def test_that_it_works_with_config_file_via_environment_variable
    ENV['HUMIDITY-CONTROL_CONFIG_FILE'] = 'test/humidity_control_test.config'
    config = Config.new
    assert config.instance_of?(Config)
  end

  def test_that_it_works_with_config_file_via_argument
    config = Config.new('test/humidity_control_test.config')
    assert config.instance_of?(Config)
  end

  def test_that_phone_nbr_from_exists
    assert Config.new.phone_nbr_from
  end

  def test_that_phone_nbr_to_exists
    assert Config.new.phone_nbr_to
  end

  def test_that_url_sensor_exists
    assert Config.new.url_sensor
  end

  def test_that_retries_exists
    assert Config.new.retries
  end
end
