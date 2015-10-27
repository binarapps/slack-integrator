require 'spec_helper'

describe "reservation actions", :type => :feature, :js => true do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_user(user)
  end

  it 'creates new reservation' do
    visit '/'
    click_button 'Create new reservation'
    fill_in 'from', with: '11'
    fill_in 'to', with: '12'

    expect(Reservation.count).to match(0)
    click_button 'Save'
    wait_for_ajax
    expect(Reservation.count).to match(1)
  end

  it 'returns reservation alreay exists error' do
    FactoryGirl.create(:reservation, from: '11', to: '12')
    visit '/'
    click_button 'Create new reservation'
    fill_in 'from', with: '11'
    fill_in 'to', with: '12'

    expect(Reservation.count).to match(1)
    wait_for_ajax
    click_button 'Save'
    expect(page).to have_content 'Sorry, errors occured: DateAlreadyReserved'
    expect(Reservation.count).to match(1)
  end

  it 'returns empty params error' do
    visit '/'
    click_button 'Create new reservation'
    fill_in 'from', with: ''
    fill_in 'to', with: ''

    expect(Reservation.count).to match(0)
    wait_for_ajax
    click_button 'Save'
    expect(page).to have_content 'Sorry, errors occured: from is not present, to is not present'
    expect(Reservation.count).to match(0)
  end
end
