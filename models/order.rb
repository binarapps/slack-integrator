require "sequel"

class Order < Sequel::Model
  many_to_one :order_list
end
