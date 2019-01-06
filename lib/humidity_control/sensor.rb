# Represents a humidty sensor
class Sensor
  def initialize(config: Config.new)
    @config = config
  end

  def reading
    response.parsed_response['ESP32']['sensor']['interpretation']
    # TODO: Parse more fields from ESP32
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't read or parse from #{@config.url_sensor}!\n#{errormsg}"
    raise
  end

  private

  def response
    retries = 0
    begin
      HTTParty.get(@config.url_sensor, headers: { 'Accept' => 'application/json' })
    rescue StandardError => errormsg
      raise unless (retries += 1) <= @config.retries

      LOGGER.warn "Error while trying to read from #{@config.url_sensor}!\n#{errormsg}\nRetrying in #{retries} second(s)..."
      sleep(retries)
      retry
    end
  end
end
