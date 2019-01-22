# Represents an alert
class Alert
  def initialize(message:, level:, config: Config.new)
    @message = message
    @level = level
    @config = config

    if @level == :alarm
      alarm
    else
      info
    end
    puts "#{@level}: #{@message}"
  end

  # Sends an SMS via Twilio
  def info
    client = Twilio::REST::Client.new @config.account_sid, @config.auth_token
    client.messages.create(
      from: @config.phone_nbr_from,
      to: @config.phone_nbr_to,
      body: @message
    )
  rescue StandardError => errormsg
    LOGGER.warn "Message probably not sent!\nMessage: #{@message}\nError: #{errormsg}!"
  end

  # Makes a call via Twilio
  def alarm
    client = Twilio::REST::Client.new @config.account_sid, @config.auth_token
    client.calls.create(
      from: @config.phone_nbr_from,
      to: @config.phone_nbr_to,
      url: @config.twiml_bin_message_url + 'Achtung+Alarm+Wasser+ist+im+Heizungskeller'
    )
    info # Send an additional info
    LOGGER.info "Alarm was sent. Waiting #{@config.repeat_alarm_pause / 60} minutes..."
    sleep @config.repeat_alarm_pause
  rescue StandardError => errormsg
    LOGGER.warn "Message probably not sent!\nMessage: #{@message}\nError: #{errormsg}!"
  end
end
