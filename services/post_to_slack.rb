class PostToSlack

  def self.say(bot, message)
    if production?
      @bot = RodaApp.opts[bot]
      @bot.say(message)
    end
  end

end
