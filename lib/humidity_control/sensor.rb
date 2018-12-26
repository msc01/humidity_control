# Represents a humidty sensor
class Sensor
  attr_reader :reading

  def initialize
    url = 'http://192.168.178.222'
    response = HTTParty.get(url, headers: { 'Accept' => 'application/json' })
    @reading = response.parsed_response['ESP32']['sensor']['interpretation']
  end
end
