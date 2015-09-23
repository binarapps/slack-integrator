class PostToSlack

  def self.say(bot, message)
    @bot = RodaApp.opts[bot]
    @bot.say(message)
  end

end
