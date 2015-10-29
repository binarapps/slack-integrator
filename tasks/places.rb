require 'yaml'
require './models.rb'

namespace :places do
  task :create do
    places = YAML::load(File.open('places.yml'))
    names = places.keys
    names.each do |name|
      places[name]['name'] = name
      Place.find_or_create(places[name])
    end
    puts '<= places created'
  end
end
