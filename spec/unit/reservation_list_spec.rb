require 'spec_helper'

describe "Paginated list" do

  let(:user) { FactoryGirl.create(:user) }

  it "should get reservation lists from proper day" do
    FactoryGirl.create(:reservation, from: '10', to: '11')
    FactoryGirl.create(:reservation, from: '12', to: '13')
    FactoryGirl.create(:reservation, from: '14', to: '15')
    FactoryGirl.create(:reservation, reserved_at: (Time.now + 86400), from: '10', to: '11')

    expect(Reservation.by_day(Time.now).count).to match(3)
    expect(Reservation.by_day(Time.now + 86400).count).to match(1)
    expect(Reservation.by_day(Time.now + 86400 * 2).count).to match(0)
  end
end
