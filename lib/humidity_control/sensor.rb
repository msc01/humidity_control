# Represents a humidty sensor
class Sensor
  attr_reader :type, :uptime, :builtin_led, :value, :reading, :warnings

  def initialize(config: Config.new)
    @config = config
    @warnings = 0
    clear_attributes
  end

  def read
    parse_attributes response.parsed_response['ESP32']
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't read or parse from #{@config.sensor_url_internal}: #{errormsg}."
    @warnings += 1
    raise
  end

  def response
    clear_attributes
    begin
      HTTParty.get(@config.sensor_url_internal, headers: { 'Accept' => 'application/json' })
    rescue StandardError => errormsg
      raise unless (@nbr_of_retries += 1) <= @config.nbr_of_retries

      LOGGER.warn "Error while trying to read #{@config.sensor_url_internal}: #{errormsg}. Retrying in #{@nbr_of_retries} s..."
      pause
      retry
    end
  end

  def ready_for_status_update?(current_time = Time.now)
    return true if current_time.hour == 12 && current_time.min.zero? && current_time.sec < 20

    false
  end

  private

  def clear_attributes
    @type = 'unknown'
    @uptime = 0
    @builtin_led = 'unknown'
    @value = 0
    @reading = 'unknown'
    @nbr_of_retries = 0
  end

  def parse_attributes(esp32)
    @type = esp32['sensor']['type']
    @uptime = esp32['status']['uptime']
    @builtin_led = esp32['status']['LED_builtin']
    @value = esp32['sensor']['value']
    @reading = esp32['sensor']['interpretation']
  end

  def pause
    @warnings += 1
    sleep(@nbr_of_retries)
  end
end
