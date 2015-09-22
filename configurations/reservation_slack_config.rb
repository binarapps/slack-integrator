class ReservationSlackConfig
    CONFIG = {
      'channel'          =>  ENV.fetch('RESERVATION_CHANNEL'),
      'name'             => 'botsy',
      'incoming_webhook' =>  ENV.fetch('INCOMING_WEBHOOK'),
      'outgoing_token'   =>  ENV.fetch('OUTGOING_TOKEN')
    }
end
