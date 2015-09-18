require "roda"
require "./models"

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
            @reservation = Reservation.new(r.params)

            if @reservation.valid? && @reservation.save
              @reservation
            else
              r.response.status = 400
              @reservation.errors
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
