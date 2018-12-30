# Represents a humidty sensor
class Sensor
  attr_reader :reading

  def initialize(config: Config.new)
    @config = config

    response = HTTParty.get(@config.url_sensor, headers: { 'Accept' => 'application/json' })
    @reading = response.parsed_response['ESP32']['sensor']['interpretation']
    # TODO: Parse more fields.
  rescue StandardError => errormsg
    LOGGER.warn "Warning: Couldn't read or parse from #{@config.url_sensor}!\n#{errormsg}"
    # TODO: rescue IOError; redo;
    @reading = 'unknwon'
  end
end
