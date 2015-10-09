require 'spec_helper'

describe "Reservation index list", :type => :feature, :js => true do

  let(:user){ FactoryGirl.create(:user) }

  it "should get reservation lists from proper day" do
    FactoryGirl.create(:reservation, from: '10', to: '11')
    FactoryGirl.create(:reservation, from: '12', to: '13')
    FactoryGirl.create(:reservation, from: '14', to: '15')
    Reservation.create(reserved_at: (DateTime.now + 1), from: '10', to: '11')

    expect(Reservation.by_day(DateTime.now).count).to match(3)
    expect(Reservation.by_day(DateTime.now + 1).count).to match(1)
    expect(Reservation.by_day(DateTime.now + 2).count).to match(0)
  end
end
