require "roda"
require "./models"

class RodaApp < Roda

  plugin :render, engine: 'haml'

  route do |r|
    r.root do
      @reservations = Reservation.all
      view('home')
    end

    r.on "api" do

      r.post do
        @reservation = Reservation.create(r.params)
      end

    end
  end
end
