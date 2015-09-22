require "roda"
require "byebug"
require 'slackbotsy'
require 'set'
require 'open-uri'
require './models'
require './domains/create_reservation'
require './domains/post_to_slack'
require './configurations/reservation_slack_config'
require './helpers/enviroment'

class RodaApp < Roda
  plugin :render, engine: 'haml'
  plugin :json, :classes=>[Sequel::Model, Array, Hash]
  plugin :default_headers, 'Content-Type'=>'application/json'

  route do |r|
    r.root do
      response['Content-Type'] = 'text/html'
      @reservations = Reservation.today
      view('reservations/index')
    end

    # /api
    r.on "api" do

      # /api/reservations
      r.on "reservations" do

          # POST /api/reservations
          r.post do
            reservation = CreateReservation.new(r.params)
            reservation.create

            if reservation.persisted?
              PostToSlack.new(ReservationSlackConfig::CONFIG, reservation.success_message).say if production?
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
