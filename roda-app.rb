require 'roda'
require 'byebug'
require 'slackbotsy'
require 'open-uri'
require 'set'

require_relative 'models'
Dir["./services/*.rb"].each {|file| require file }
Dir["./configurations/*.rb"].each {|file| require file }
Dir["./helpers/*.rb"].each {|file| require file }

class RodaApp < Roda
  # bots init
  opts[:reservation_bot] = Slackbotsy::Bot.new(ReservationSlackConfig::CONFIG)
  # uncomment this line if you want to include your assets
  # plugin :assets, YAML.load_file('assets/manifest.yml')
  plugin :render, engine: 'haml'
  plugin :json, :classes=>[Sequel::Model, Array, Hash]
  plugin :default_headers, 'Content-Type'=>'application/json'
  plugin :multi_route
  plugin :shared_vars
  plugin :sinatra_helpers

  route do |r|
    # r.assets
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
