# Represents an alert
class Alert
  def initialize(message:, level:, config: Config.new)
    @message = message
    @level = level
    @config = config

    @config.phone_nbr_to.each do |nbr|
      alarm nbr if @level == :alarm
      info nbr
    end
    return unless @level == :alarm

    LOGGER.info "Waiting #{@config.repeat_alarm_pause / 60} minutes after an alarm..."
    sleep @config.repeat_alarm_pause
  end

  # Sends an SMS via Twilio
  def info(receiver)
    client = Twilio::REST::Client.new @config.account_sid, @config.auth_token
    client.messages.create(
      from: @config.phone_nbr_from,
      to: receiver,
      body: @message
    )
  rescue StandardError => errormsg
    LOGGER.warn "Message probably not sent!\nReceiver: #{receiver}\nMessage: #{@message}\nError: #{errormsg}!"
  else
    LOGGER.info "Info: #{@message} was sent to #{receiver}."
  end

  # Makes a call via Twilio
  def alarm(receiver)
    client = Twilio::REST::Client.new @config.account_sid, @config.auth_token
    client.calls.create(
      from: @config.phone_nbr_from,
      to: receiver,
      url: @config.twiml_bin_message_url + 'Achtung+Alarm+Wasser+ist+im+Heizungskeller'
    )
  rescue StandardError => errormsg
    LOGGER.warn "Call probably not made!\nReceiver: #{receiver}\nMessage: #{@message}\nError: #{errormsg}!"
  else
    LOGGER.info "Alarm: #{receiver} called."
  end
end
