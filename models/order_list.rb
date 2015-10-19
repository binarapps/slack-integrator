require "sequel"

class OrderList < Sequel::Model
  many_to_one :place
  one_to_many :orders

end
