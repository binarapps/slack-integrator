class FoodSlackConfig
  CONFIG = {
    'channel'          =>  ENV.fetch('FOOD_ORDER_CHANNEL'),
    'name'             => 'Jedzenie',
    'incoming_webhook' =>  ENV.fetch('FOOD_ORDER_INCOMING_WEBHOOK'),
    'outgoing_token'   =>  ENV.fetch('FOOD_ORDER_OUTGOING_TOKEN')
  }
end
