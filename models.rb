require "sequel"
require 'dotenv'
Dotenv.load

unless test?
  DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
else
  DB = Sequel.connect(ENV.fetch('TEST_DATABASE_URL'))
end

require './models/reservation.rb'
require './models/user.rb'
