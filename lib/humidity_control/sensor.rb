# Represents a humidty sensor
class Sensor
  attr_reader :type, :uptime, :builtin_led, :value, :reading, :warnings

  def initialize(config: Config.new)
    @config = config
    @warnings = 0
    initialize_attributes
  end

  def read
    parse_attributes response.parsed_response['ESP32']
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't read or parse from #{@config.url_sensor}!\n#{errormsg}"
    @warnings += 1
    raise
  end

  def response
    retries = 0
    initialize_attributes
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

  def initialize_attributes
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
end
