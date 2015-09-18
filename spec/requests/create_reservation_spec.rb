require 'spec_helper'

describe 'Create reservation' do

  context 'proper params' do

    it 'should create a reservation' do
      post 'api/reservations', { reserved_at: Date.today, from: '11', to: '12'}, { 'Content-Type' => 'application/json' }

      expect(last_response.status).to eq(200)
      expect(Reservation.count).to eq(1)
    end

  end

  context 'invalid params' do
    it 'should not create a reservation with blank params' do
      post 'api/reservations', { }

      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(0)

      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response['reserved_at']).to eq(['is not present'])

    end
  end

end
