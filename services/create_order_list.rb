class OrderListNotClosed < Exception; end

class CreateOrderList

  def initialize(params)
    @params = factor_params(params)
  end

  def call
    place = Place.where(name: @params).first
    if OrderList.last && !OrderList.last.closed
      raise OrderListNotClosed
    end
    if place
      OrderList.create(place: place, created_at: Date.today)
      message = "Place choosed - #{ place.full_name }! Now order whatever you want. Schema: #{ place.schema }"
    else
      message = "No such place as #{ @params }"
    end
    message
  end
end
