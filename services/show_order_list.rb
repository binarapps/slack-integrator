class ShowOrderList

  def self.message
    order_list = OrderList.last
    orders = order_list.show_orders
    if order_list.closed
      "Orders are closed... Anyway last ones: \n #{orders}"
    else
      "Check if its okey: \n #{orders}"
    end
  end
end
