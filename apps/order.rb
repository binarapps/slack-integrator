RodaApp.route('order') do |r|

  # POST /api/orders/new
  r.post 'new' do
    message = CreateOrder.new(r.params).call
    PostToSlack.say(:food_bot, message) unless test?
    status(200)
  end

  # POST /api/orders/show
  r.post 'show' do
    order_list = OrderList.last
    orders = order_list.show_orders
    if order_list.closed
      PostToSlack.say(:food_bot, 'Orders are closed... Anyway last ones: \n #{orders}') unless test?
    else
      PostToSlack.say(:food_bot, 'Check if its okey: \n #{orders}') unless test?
    end
    status(200)
  end

  # POST /api/orders/close
  r.post 'close' do
    order_list = OrderList.last
    orders = order_list.show_orders
    if order_list.closed
      PostToSlack.say(:food_bot, 'Already closed') unless test?
    else
      order_list.update(closed: true)
      PostToSlack.say(:food_bot, 'Ordering closed. #{order_list.place.full_name} \n Here is the phone number #{order_list.place.phone} \n #{orders}') unless test?
    end
    status(200)
  end

  # POST /api/orders/menu
  r.post 'menu' do
    menu = Place.list
    PostToSlack.say(:food_bot, menu) unless test?
    status(200)
  end

  # POST /api/orders/place
  r.post 'place' do
    begin
      message = CreateOrderList.new(r.params).call
      PostToSlack.say(:food_bot, message) unless test?
      status(200)
    rescue OrderListNotClosed
      PostToSlack.say(:food_bot, 'Order already open. Cant create new one!') unless test?
      status(200)
    end
  end
end

