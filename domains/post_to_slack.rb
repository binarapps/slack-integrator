class PostToSlack

  def initialize(config, message)
    @bot = Slackbotsy::Bot.new(config)
    @message = message
  end

  def say
    @bot.say(@message)
  end

end
