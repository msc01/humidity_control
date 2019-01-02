# Represents an alert
class Alert
  def initialize(message:, level:, config: Config.new)
    @message = message
    @level = level
    @config = config

    case @level
    when :alarm
      alarm
    else
      info
    end
  end

  def alarm
    client = Twilio::REST::Client.new @config.account_sid, @config.auth_token
    client.messages.create(
      from: @config.phone_nbr_from,
      to: @config.phone_nbr_to,
      body: @message
    )

    puts "Alarm: #{@message}"
    # `say 'Alarm'` command not running on production iMac
  rescue StandardError => errormsg
    LOGGER.warn "Warning: Message probably not sent!\nMessage: #{@message}\nError: #{errormsg}!"
    # TODO: rescue IOError; redo;
  end

  def info
    puts "Info: #{@message}"
  end
end
