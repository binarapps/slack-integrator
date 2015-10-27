require "sequel"

class Place < Sequel::Model
  one_to_many :order_lists

  alias_method :save!, :save

  def self.list
    list = "Available places \n"
    Place.all.each { |place| list << "#{place.name} , menu: #{place.menu} \n" }
    list
  end
end
