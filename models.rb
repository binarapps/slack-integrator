require "sequel"

DB = Sequel.connect("postgres://#{ENV['PGUSER']}:#{ENV['PGPASSWORD']}@127.0.0.1:5432/roda-app-development")

require './models/reservation.rb'
