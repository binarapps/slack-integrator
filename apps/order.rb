RodaApp.route('order') do |r|
  # POST /api/orders/new
  r.post 'new' do
    message = CreateOrder.new(r.params).call
    PostToSlack.say(:food_bot, message)
    status(200)
  end

  # POST /api/orders/show
  r.post 'show' do
    message = ShowOrderList.message
    PostToSlack.say(:food_bot, message)
    status(200)
  end

  # POST /api/orders/close
  r.post 'close' do
    message = CloseOrderList.call
    PostToSlack.say(:food_bot, message)
    status(200)
  end

  # POST /api/orders/menu
  r.post 'menu' do
    menu = Place.list
    PostToSlack.say(:food_bot, menu)
    status(200)
  end

  # POST /api/orders/place
  r.post 'place' do
    begin
      message = CreateOrderList.new(r.params).call
      PostToSlack.say(:food_bot, message)
      status(200)
    rescue OrderListNotClosed
      PostToSlack.say(:food_bot, 'Order already open. Cant create new one!')
      status(200)
    end
  end
end
