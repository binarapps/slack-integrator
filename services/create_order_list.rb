class OrderListNotClosed < Exception; end

class CreateOrderList
  def initialize(params)
    @params = factor_params(params)
  end

  def call
    place = Place.where(name: @params).first
    check_if_list_is_closed
    if place
      OrderList.create(place: place, created_at: Date.today)
      "Place choosed - #{place.full_name}! Now order whatever you want. Schema: #{place.schema}"
    else
      "No such place as #{@params}"
    end
  end

  private

  def check_if_list_is_closed
    if OrderList.last && !OrderList.last.closed
      raise OrderListNotClosed
    end
  end
end
