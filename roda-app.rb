require "roda"
require "byebug"
require 'slackbotsy'
require 'set'
require 'open-uri'
require './models'
require './services/create_reservation'
require './services/post_to_slack'
require './configurations/reservation_slack_config'
require './helpers/enviroment'

class RodaApp < Roda
  plugin :render, engine: 'haml'
  plugin :json, :classes=>[Sequel::Model, Array, Hash]
  plugin :default_headers, 'Content-Type'=>'application/json'
  plugin :multi_route
  plugin :shared_vars
  plugin :sinatra_helpers

  route do |r|
    r.root do
      response['Content-Type'] = 'text/html'
      @reservations = Reservation.today
      view('reservations/index')
    end
    require_relative 'apps/reservation'

    # /api
    r.on "api" do

      # /api/reservations
      r.on "reservations" do
        r.route 'reservation'
      end

    end
  end
end
