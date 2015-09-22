require 'spec_helper'

describe 'Create reservation' do
  let(:proper_params) { "#{Date.today.day}/#{Date.today.month}-15:30-16:15" }
  let(:wrong_format_params) { "#{Date.today.day}-#{Date.today.month}:15:30:16:15" }

  context 'proper params' do

    it 'should create a reservation' do
      post 'api/reservations', { text: proper_params }

      expect(last_response.status).to eq(200)
      expect(Reservation.count).to eq(1)
      reservation = Reservation.last
      expect(reservation.from).to eq('15:30')
      expect(reservation.to).to eq('16:15')
    end

  end

  context 'invalid params' do
    it 'should not create a reservation with blank params' do
      post 'api/reservations', { text: '' }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(0)
    end

    it 'should not create a reservation with wrong format params' do
      post 'api/reservations', { text: wrong_format_params }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(0)
    end

    it 'should not create a reservation when there is already reserved one' do
      Reservation.create(reserved_at: Date.today, from: "15:30", to: "16:30")

      post 'api/reservations', { text: proper_params }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(1)
    end
  end

end
