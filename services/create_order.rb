class CreateOrder
  def initialize(params)
    @item = factor_params(params)
    @user_name = params['user_name']
  end

  def call
    order_list = OrderList.last
    if order_list.closed
      'Order already closed, please create new'
    else
      Order.create(item: @item, order_list: order_list, user_name: @user_name)
      PostToSlack.say(:food_bot, '#{@user_name}: Order created to #{order_list.place.full_name}') unless test?
    end
  end
end
