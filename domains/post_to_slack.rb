class PostToSlack

  def initialize(config, message)
    @bot = Slackbotsy::Bot.new(config)
    @message = message
  end

  def say
    @bot.say(@message) if production?
  end

  private
  def production?
    ENV.fetch('RACK_ENV') == 'production'
  end

end
