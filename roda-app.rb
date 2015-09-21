require "roda"
require "byebug"
require "./models"
require "./lib/create_reservation"

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
              reservation_create.reservation
            else
              r.response.status = 400
              reservation_create.errors
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
