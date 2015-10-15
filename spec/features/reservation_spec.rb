require 'spec_helper'

describe "reservation actions", :type => :feature, :js => true do

  let(:user){ FactoryGirl.create(:user) }

  it "creates new reservation" do
    login_user(user)
    visit '/'
    click_button 'Create new reservation'
    fill_in 'from', :with => '11'
    fill_in 'to', :with => '12'

    click_button 'Save'
    expect(Reservation.count).to match(1)
  end

  it "returns reservation alreay exists error" do
    login_user(user)
    FactoryGirl.create(:reservation, from: '11', to: '12')
    visit '/'
    click_button 'Create new reservation'
    fill_in 'from', :with => '11'
    fill_in 'to', :with => '12'

    click_button 'Save'
    expect(Reservation.count).to match(1)
  end

  it "returns empty params error" do
    login_user(user)
    FactoryGirl.create(:reservation, from: '11', to: '12')
    visit '/'
    click_button 'Create new reservation'
    fill_in 'from', :with => ''
    fill_in 'to', :with => ''

    click_button 'Save'
    expect(Reservation.count).to match(1)
  end
end
