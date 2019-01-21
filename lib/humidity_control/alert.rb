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
      url: @config.twiml_bin_message_url + @message.gsub(/[ @:–+-\/\=]/, '_').tr_s('_', '+')
    )
    info # Send an additional info
    LOGGER.info 'Waiting 15 minutes after an alarm...'
    sleep 900
  rescue StandardError => errormsg
    LOGGER.warn "Message probably not sent!\nMessage: #{@message}\nError: #{errormsg}!"
  end
end
