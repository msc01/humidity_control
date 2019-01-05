# Represents a humidty sensor
class Sensor
  attr_reader :url

  def initialize(config: Config.new)
    @url = config.url_sensor
    @retries = config.retries
  end

  def reading
    response.parsed_response['ESP32']['sensor']['interpretation']
    # TODO: Parse more fields from ESP32
  rescue StandardError => errormsg
    LOGGER.warn "Warning: Couldn't read or parse from #{@url}!\n#{errormsg}"
    'unknwon'
  end

  private

  def response
    retries = 0
    begin
      HTTParty.get(@url, headers: { 'Accept' => 'application/json' })
    rescue IOError => errormsg
      if (retries += 1) <= @retries
        LOGGER.warn "Warning: IO-Error while trying to read from #{@url}!\n#{errormsg}\nRetrying in #{retries} second..."
        sleep(retries)
        retry
      else
        raise
      end
    end
  end
end
