# Handles external configuration data and makes each configuration parameter accessible as an attribut.
class Config
  # Humidity Control: Environment
  attr_reader :environment
  # Twilio configuration: account
  attr_reader :account_sid
  # Twilio configuration: authorization token ("password")
  attr_reader :auth_token
  # Phone configuration: sender's phone number
  attr_reader :phone_nbr_from
  # Phone configuration: receiver's phone number
  attr_reader :phone_nbr_to
  # URL of TWIML BIN for message text to say during calls
  attr_reader :twiml_bin_message_url
  # Sensor configuration: URL internal net
  attr_reader :sensor_url_internal
  # Sensor configuration: URL external net
  attr_reader :sensor_url_external
  # Sensor configuration: Number of retries for trying to access services
  attr_reader :nbr_of_retries
  # Seconds to suspend alerting after sending an alarm to stop repeat alarming
  attr_reader :repeat_alarm_pause

  def initialize(config_file = ENV['HUMIDITY_CONTROL_CONFIG_FILE'] || 'data/.config')
    @config_file = config_file
    get_config_attributes_from config_data
    LOGGER.debug "Configuration file = #{@config_file}"
    LOGGER.info "Environment = #{@environment} – Version = #{VERSION}"
  end

  private

  def get_config_attributes_from(configuration)
    @environment = configuration['environment']
    @phone_nbr_from = configuration['phone_nbr_from']
    @phone_nbr_to = configuration['phone_nbr_to']
    @auth_token = configuration['auth_token']
    @account_sid = configuration['account_sid']
    @twiml_bin_message_url = configuration['twiml_bin_message_url']
    @sensor_url_internal = configuration['sensor_url_internal']
    @sensor_url_external = configuration['sensor_url_external']
    @nbr_of_retries = configuration['nbr_of_retries']
    @repeat_alarm_pause = configuration['repeat_alarm_pause']
  end

  def config_data
    YAML.load_file(@config_file)
  rescue Errno
    LOGGER.error "Configuration file #{@config_file} not found!"
    abort('PROGRAMM ABORTED!')
  end
end
