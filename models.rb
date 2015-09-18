require "sequel"
require 'dotenv'
Dotenv.load
DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

require './models/reservation.rb'
