class CloseOrderList

  def self.call
    order_list = OrderList.last
    orders = order_list.show_orders
    if order_list.closed
      "Orders already closed!"
    else
      order_list.update(closed: true)
      "Ordering closed. #{order_list.place.full_name} \n Here is the phone number #{order_list.place.phone} \n #{orders}"
    end
  end
end
