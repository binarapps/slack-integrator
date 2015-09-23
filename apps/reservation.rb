require 'set'

RodaApp.route('reservation') do |r|
  # POST /api/reservations
  r.post do
    begin
      @reservation = CreateReservation.new(r.params)
      @reservation.create

      PostToSlack.new(ReservationSlackConfig::CONFIG, @reservation.success_message).say if production?
      status(200)

      rescue ArgumentError, EmptyParams, DateAlreadyReserved, Sequel::ValidationFailed => e
        status(400)
        @reservation.error_message(e)
    end
  end

  # GET api/reservations
  r.get do
    Reservation.all
  end

end
