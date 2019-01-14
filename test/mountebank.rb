# Supplies methods to deal with Mountebank during tests
module Mountebank
  MOUNTEBANK_ADDRESS = 'http://localhost:2525/imposters/'.freeze

  # --- Preparation and setup
  #     Assumes that [Mountebank][http://www.mbtest.org] is up an running
  def mountebank
    # First, delete any old imposters
    mountebank_delete
    # Then, setup imposter needed for testing
    mountebank_setup
  end

  def mountebank_delete
    HTTParty.delete(MOUNTEBANK_ADDRESS)
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't delete from Mountebank@#{MOUNTEBANK_ADDRESS}!\n#{errormsg}"
    raise
  end

  def mountebank_setup
    body = <<~HEREDOC
      {"port": 1000, "protocol": "http", "name": "ESP32-FC37", "stubs": [{"predicates": [{"equals": {"method": "GET", "path": "/"}}], "responses": [{"is": {"statusCode": 200, "headers": {"Content-Type": "application/json"}, "body": {"ESP32": {"status": {"uptime": "1", "LED_builtin": "off"}, "sensor": {"type": "FC37", "value": "4095", "interpretation": "dry"}}}}}]}]}
    HEREDOC

    HTTParty.post(MOUNTEBANK_ADDRESS, body: body, headers: { 'Content-Type' => 'application/json' })
  rescue StandardError => errormsg
    LOGGER.warn "Couldn't post to Mountebank@#{MOUNTEBANK_ADDRESS}!\n#{errormsg}"
    raise
  end
end
