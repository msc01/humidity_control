# Represents a humidty sensor
class Sensor
  attr_reader :reading

  def initialize(config: Config.new)
    @config = config

    response = HTTParty.get(@config.url_sensor, headers: { 'Accept' => 'application/json' })
    @reading = response.parsed_response['ESP32']['sensor']['interpretation']
  rescue StdError
    @reading = 'unknwon'
  end
end
