RodaApp.route('order') do |r|

  # daj
  # POST /api/orders/new
  r.post 'new' do
    order_list = OrderList.last
    params = r.params['text'].split(r.params['trigger_word'])[1]
    if order_list.closed
      PostToSlack.say(:food_bot, 'Order already closed, please create new (walimy_z)')
    else
      Order.create(item: params, order_list: order_list, user_name: r.params['user_name'])
      PostToSlack.say(:food_bot, "Order created to #{ order_list.place.full_name }")
    end
  end

  # poka
  # POST /api/orders/show
  r.post 'show' do
    order_list = OrderList.last
    orders = ''
    order_list.orders.each do |ord|
      orders << ("@#{ord.user_name}: #{ord.item} \n")
    end
    if order_list.closed
      puts 'Zamowienia zamkniete'
      PostToSlack.say(:food_bot, "Orders are closed... Anyway last ones: \n #{ orders }")
    else
      PostToSlack.say(:food_bot, "Check if its okey: \n #{ orders }")
    end
  end

  # jazda
  # POST /api/orders/close
  r.post 'close' do
    order_list = OrderList.last
    if order_list.closed
      PostToSlack.say(:food_bot, "Already closed")
    else
      order_list.update(closed: true)
      PostToSlack.say(:food_bot, "Ordering closed. #{ order_list.place.full_name } \n Here is the phone number #{order_list.place.phone}")
    end
  end

  # menu
  # POST /api/orders/menu
  r.post 'menu' do
    #TODO all places (possibly with menu)
  end

  # walimy_z
  # POST /api/orders/place
  r.post 'place' do
    params = r.params['text'].split(r.params['trigger_word'])[1].delete(' ')
    place = Place.where(name: params).first
    if place
      OrderList.create(place: place, created_at: Date.today)
      PostToSlack.say(:food_bot, "Place choosed - #{ place.full_name }! Now order whatever you want. Schema: #{ place.schema }")
    else
      PostToSlack.say(:food_bot, "No such place as #{ params }")
    end
    status(200)
  end
end

