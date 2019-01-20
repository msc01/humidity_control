require_relative 'test_helper'

# Test class for Minitest Unit Tests
class ConfigTest < Minitest::Test
  def test_that_instance_is_of_right_class
    config = Config.new
    assert config.instance_of?(Config)
  end

  def test_that_it_works_with_default_config_file
    ENV['HUMIDITY_CONTROL_CONFIG_FILE'] = nil
    config = Config.new
    assert config.instance_of?(Config)
  end

  def test_that_it_does_not_work_without_a_config_file
    assert_raises(Errno::ENOENT) { Config.new('data/no.config') }
  end

  def test_that_it_works_with_config_file_via_environment_variable
    ENV['HUMIDITY_CONTROL_CONFIG_FILE'] = 'test/test.config'
    config = Config.new
    assert config.instance_of?(Config)
  end

  def test_that_it_works_with_config_file_via_argument
    config = Config.new('test/test.config')
    assert config.instance_of?(Config)
  end

  def test_that_environment_exists
    assert Config.new.environment
  end

  def test_that_phone_nbr_from_exists
    assert Config.new.phone_nbr_from
  end

  def test_that_phone_nbr_to_exists
    assert Config.new.phone_nbr_to
  end

  def test_that_sensor_url_exists
    assert Config.new.sensor_url
  end

  def test_that_retries_exists
    assert Config.new.retries
  end
end
