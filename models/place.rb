require "sequel"

class Place < Sequel::Model
  one_to_many :order_lists

  alias_method :save!, :save

  def self.list
    list = "Dostępne miejsca \n"
    Place.all.each do |place|
      list << ("#{place.name} , menu: #{place.menu} \n")
    end
    list
  end
end
