class ReservationSlackConfig
  CONFIG = {
    'channel'          =>  ENV.fetch('RESERVATION_CHANNEL'),
    'name'             => 'botsy',
    'incoming_webhook' =>  ENV.fetch('RESERVATION_INCOMING_WEBHOOK'),
    'outgoing_token'   =>  ENV.fetch('RESERVATION_OUTGOING_TOKEN')
  }
end
