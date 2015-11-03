require 'spec_helper'

describe "the signup process", :type => :feature, :js => true do

  context 'with proper params' do

    it "signs me up" do
      visit '/user_registrations/new'
      fill_in 'email', :with => 'user@example.com'
      fill_in 'github_login', :with => 'some_login'
      fill_in 'password', :with => 'password'
      fill_in 'password_confirmation', :with => 'password'

      click_button 'Sign up'
      expect(User.count).to eq(1)
      expect(page).to have_content 'Log in'
    end
  end

  context 'with invalid params' do

    it 'raises errors when passwords not match' do
      visit '/user_registrations/new'
      fill_in 'email', :with => 'user@example.com'
      fill_in 'github_login', :with => 'some_login'
      fill_in 'password', :with => 'password'
      fill_in 'password_confirmation', :with => 'notmatch'

      click_button 'Sign up'
      expect(User.count).to eq(0)
    end
  end
end
