require "sequel"

class OrderList < Sequel::Model
  many_to_one :place
  one_to_many :orders

  alias_method :save!, :save

  def show_orders
    orders = ''
    self.orders.each do |ord|
      orders << ("@#{ord.user_name}: #{ord.item} \n")
    end
    orders
  end
end
