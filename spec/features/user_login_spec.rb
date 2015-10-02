require 'spec_helper'

describe "the sign in process", :type => :feature, :js => true do

  let(:user){ FactoryGirl.create(:user) }

  it "signs me in with proper params" do
    visit '/user_sessions/new'
    fill_in 'email', :with => user.email
    fill_in 'password', :with => user.password

    click_button 'Log in'
    expect(page).to have_content 'Logout'
  end

  it "won't sign me in with invalid params" do
    visit '/user_sessions/new'
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'wrongpassword'

    click_button 'Log in'
    expect(page).to have_content 'Please sign in'
  end

end
