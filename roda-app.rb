require "roda"
require "byebug"
require 'slackbotsy'
require 'open-uri'
require './models'
require './domains/create_reservation'
require './domains/post_to_slack'
require './configurations/reservation_slack_config'

class RodaApp < Roda
  plugin :render, engine: 'haml'
  plugin :json, :classes=>[Sequel::Model, Array, Hash]

  route do |r|
    r.root do
      @reservations = Reservation.today
      view('reservations/index')
    end

    # /api
    r.on "api" do
    plugin :default_headers, 'Content-Type'=>'application/json'

      # /api/reservations
      r.on "reservations" do

          # POST /api/reservations
          r.post do
            reservation = CreateReservation.new(r.params)
            reservation.create

            if reservation.persisted?
              PostToSlack.new(ReservationSlackConfig::CONFIG, reservation.success_message).say
              r.response.status = 200
            else
              r.response.status = 400
              reservation.error_message
            end
          end

          # GET api/reservations
          r.get do
            Reservation.all
          end

      end

    end
  end
end
