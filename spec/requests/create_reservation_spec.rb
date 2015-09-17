require 'spec_helper'

describe 'Create reservations' do

  it 'should create a reservation upon sending proper params' do
    post 'api/reservation', { reserved_at: Date.today, from: '11', to: '12'}

    expect(response.status).to eq(200)
  end

end
