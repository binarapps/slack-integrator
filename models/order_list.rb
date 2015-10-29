require 'sequel'

class OrderList < Sequel::Model
  many_to_one :place
  one_to_many :orders

  alias_method :save!, :save

  def show_orders
    OrderList.last.orders.collect { |order| "@#{order.user_name}: #{order.item} \n" }.join(' ')
  end
end
