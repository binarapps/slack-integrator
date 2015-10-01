require 'spec_helper'

describe "the signin process", :type => :feature do

  # before :each do
  #   # @user =
  #   User.create(email: 'lolo@polo.pl', password: 'password', password_confirmation: 'password')
  # end

  it "signs me in" do
    # FactoryGirl.create(:user)
    User.create(email: 'lolo@polo.pl', password: 'password', password_confirmation: 'password')

    visit '/user_sessions/new'
    fill_in 'email', :with => 'lolo@polo.pl'
    fill_in 'password', :with => 'password'

    click_button 'Log in'
    expect(page).to have_content 'Log out'
  end

  xit "signs me up" do
    visit '/user_registrations/new'
    fill_in 'email', :with => 'lolo@polo.pl'
    fill_in 'password', :with => 'password'
    fill_in 'password_confirmation', :with => 'password'

    click_button 'Sign up'
    # save_and_open_page
    expect(page).to have_content 'Log in'
  end
end
