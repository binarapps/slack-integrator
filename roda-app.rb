require "roda"
require "byebug"
require "./models"
require "./lib/parser"

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
            parser = Parser.new(r.params)
            parser.execute

            if parser.success?
              parser.reservation
            else
              r.response.status = 400
              parser.errors
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
