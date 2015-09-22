require "roda"
require "byebug"
require 'slackbotsy'
require 'open-uri'
require './models'
require './domains/create_reservation'
require './domains/post_to_slack'
require './configurations/slack'

class RodaApp < Roda
  plugin :default_headers,
    'Content-Type'=>'application/json'

  plugin :render, engine: 'haml'
  plugin :json, :classes=>[Sequel::Model, Array, Hash]

  route do |r|
    r.root do
      @reservations = Reservation.all
      view('home')
    end

    # /api
    r.on "api" do

      # /api/reservations
      r.on "reservations" do

          # POST /api/reservations
          r.post do
            reservation_create = CreateReservation.new(r.params)
            reservation_create.create

            if reservation_create.persisted?
              PostToSlack.new(Slack::CONFIG, reservation_create.success_message).say
              r.response.status = 200
            else
              r.response.status = 400
              reservation_create.error_message
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
