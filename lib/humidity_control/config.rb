# Handles external configuration data and makes each configuration parameter accessible as an attribut.
class Config
  # Twilio configuration: account
  attr_reader :account_sid
  # Twilio configuration: authorization token ("password")
  attr_reader :auth_token
  # Phone configuration: sender phone number
  attr_reader :phone_nbr_from

  def initialize(config_file = ENV['HUMIDITY-CONTROL_CONFIG_FILE'] || 'data/.humidity_control.config')
    @config_file = config_file
    get_config_attributes_from config_data
  end

  private

  def get_config_attributes_from(configuration)
    @phone_nbr_from = configuration['phone_nbr_from']
    @auth_token = configuration['auth_token']
    @account_sid = configuration['account_sid']
  end

  def config_data
    YAML.load_file(@config_file)
  rescue Errno
    LOGGER.error "Configuration file #{@config_file} not found!"
    abort('PROGRAMM ABORTED!')
  end
end
