require 'spec_helper'

describe 'Create reservation' do
  let(:proper_params) { "#{Date.today.day}/#{Date.today.month}-#{Time.now.hour}-#{Time.now.hour+1}" }
  let(:wrong_format_params) { "#{Date.today.day}-#{Date.today.month}:#{Time.now.hour}:#{Time.now.hour+1}" }
  let(:date_in_past_params) { "#{Date.today.day-1}/#{Date.today.month}-#{Time.now.hour}-#{Time.now.hour+1}" }

  context 'proper params' do

    it 'should create a reservation' do
      post 'api/reservations', { text: proper_params }

      expect(last_response.status).to eq(200)
      expect(Reservation.count).to eq(1)
    end

  end

  context 'invalid params' do
    it 'should not create a reservation with blank params' do
      post 'api/reservations', { }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(0)
    end

    it 'should not create a reservation with wrong format params' do
      post 'api/reservations', { text: wrong_format_params }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(0)
    end

    it 'should not create a reservation with date in the past' do
      post 'api/reservations', { text: date_in_past_params }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(0)
    end

    it 'should not create a reservation when there is already reserved one' do
      Reservation.create(reserved_at: Date.today, from: "#{Time.now.hour}", to: "#{Time.now.hour+1}")
      post 'api/reservations', { text: proper_params }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(1)
    end
  end

end
