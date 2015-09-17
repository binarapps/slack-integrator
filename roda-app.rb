require "roda"
require "./models"

class RodaApp < Roda

  plugin :render, engine: 'haml'

  route do |r|
    r.root do
      @reservations = Reservation.all
      view('home')
    end
  end
end
