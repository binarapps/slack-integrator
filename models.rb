require "sequel"

DB = Sequel.connect("#{ENV['DATABASE_URL']}")

require './models/reservation.rb'
