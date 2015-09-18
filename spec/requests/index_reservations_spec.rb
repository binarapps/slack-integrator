require 'spec_helper'

describe 'Index reservations' do
  let!(:reservation) { FactoryGirl.create(:reservation) }

  it 'should return reservations list' do
    get 'api/reservations', { }

    expect(last_response.status).to eq(200)
    parsed_response = JSON.parse(last_response.body)

    expect(parsed_response.size).to eq(1)
  end


end
