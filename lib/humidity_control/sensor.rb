# Represents a humidty sensor
class Sensor
  attr_reader :type, :uptime, :builtin_led, :value, :reading, :warnings

  def initialize(config: Config.new)
    @config = config
    @warnings = 0
    @day_of_creation = Time.now.day
    clear_attributes
  end

  def read
    begin
      parse_attributes response.parsed_response['ESP32']
    rescue StandardError => errormsg
      LOGGER.warn "Couldn't read or parse from #{@config.url_sensor}!\n#{errormsg}"
      @warnings += 1
      raise
    end
    Alert.new(message: 'Daily update', level: :info, config: @config) if new_day?
  end

  def response
    clear_attributes
    retries = 0
    begin
      HTTParty.get(@config.url_sensor, headers: { 'Accept' => 'application/json' })
    rescue StandardError => errormsg
      raise unless (retries += 1) <= @config.retries

      LOGGER.warn "Error while trying to read from #{@config.url_sensor}!\n#{errormsg}\nRetrying in #{retries} second(s)..."
      @warnings += 1
      sleep(retries)
      retry
    end
  end

  private

  def clear_attributes
    @type = 'unknown'
    @uptime = 0
    @builtin_led = 'unknown'
    @value = 0
    @reading = 'unknown'
  end

  def parse_attributes(esp32)
    @type = esp32['sensor']['type']
    @uptime = esp32['status']['uptime']
    @builtin_led = esp32['status']['LED_builtin']
    @value = esp32['sensor']['value']
    @reading = esp32['sensor']['interpretation']
  end

  def new_day?
    return false if @day_of_creation == Time.now.day

    @day_of_creation = Time.now.day
    true
  end
end
