require 'spec_helper'

describe 'Ordering' do
  let(:proper_params) { { user_name: 'user', text: 'trigger txt', trigger_word: 'trigger' } }
  let(:wrong_format_params) { { user_name: 'user', text: 'trigger txt' } }

  context 'Order list' do
    it 'should create ordering place' do
      FactoryGirl.create(:place)
      post 'api/orders/place', proper_params
      expect(last_response.status).to eq(200)
      expect(OrderList.count).to eq(1)
      orderlist = OrderList.last
      expect(orderlist.place).to eq(Place.last)
    end

    it 'shouldnt create order list due to still active previous one' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:order_list, place: Place.last)
      expect(OrderList.count).to eq(1)
      post 'api/orders/place', proper_params
      expect(last_response.status).to eq(200)
      expect(OrderList.count).to eq(1)
    end

    it 'shouldnt create order list due to wrong place name' do
      FactoryGirl.create(:place, name: 'anything else')
      expect(OrderList.count).to eq(0)
      post 'api/orders/place', proper_params
      expect(last_response.status).to eq(200)
      expect(OrderList.count).to eq(0)
    end
  end

  context 'New order' do
    it 'should create new order' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:order_list, place: Place.last)
      post 'api/orders/new', proper_params
      expect(Order.count).to eq(1)
      expect(Order.last.user_name).to eq('user')
    end
  end

  context 'Close order list' do
    it 'should close last order list' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:order_list, place: Place.last)
      FactoryGirl.create(:order, order_list: OrderList.last)
      post 'api/orders/close'
      expect(OrderList.last.closed).to eq(true)
    end
  end
end
