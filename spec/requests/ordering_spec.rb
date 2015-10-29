require 'spec_helper'

describe 'Ordering' do
  let(:proper_params) { { user_name: 'user', text: 'trigger txt', trigger_word: 'trigger' } }
  let(:wrong_params) { { user_name: 'user', text: 'trigger anything_else', trigger_word: 'trigger' } }

  let!(:place) { FactoryGirl.create(:place) }
  let!(:order_list) { FactoryGirl.create(:order_list, place: Place.last) }
  let!(:order) { FactoryGirl.create(:order, order_list: OrderList.last) }

  context 'Order list' do
    it 'should create ordering place' do
      post 'api/orders/place', proper_params
      expect(last_response.status).to eq(200)
      expect(OrderList.count).to eq(1)
      orderlist = OrderList.last
      expect(orderlist.place).to eq(Place.last)
    end

    it 'should not create order list due to still active previous one' do
      expect(OrderList.count).to eq(1)
      post 'api/orders/place', proper_params
      expect(last_response.status).to eq(200)
      expect(OrderList.count).to eq(1)
    end

    it 'should not create order list due to wrong place name' do
      expect(OrderList.count).to eq(1)
      post 'api/orders/place', wrong_params
      expect(last_response.status).to eq(200)
      expect(OrderList.count).to eq(1)
    end
  end

  context 'New order' do
    it 'should create new order' do
      post 'api/orders/new', proper_params
      expect(Order.count).to eq(2)
      expect(Order.last.user_name).to eq('user')
    end

    it 'should not create new order due to closed order list' do
      expect(Order.count).to eq(1)
      OrderList.last.update(closed: true)
      post 'api/orders/new', proper_params
      expect(Order.count).to eq(1)
    end
  end

  context 'Close order list' do
    it 'should close last order list' do
      post 'api/orders/close'
      expect(OrderList.last.closed).to eq(true)
    end
  end
end
