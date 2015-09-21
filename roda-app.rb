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
              # reservation_create.reservation.to_json
              r.response.write('Reservation created')
            else
              r.response.status = 400
              r.response.write("Error: #{reservation_create.errors.inspect}")
              # reservation_create.errors.to_json
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
