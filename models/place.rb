require "sequel"

class Place < Sequel::Model
  one_to_many :order_lists
end
