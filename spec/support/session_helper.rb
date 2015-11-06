def login_user(user)
  visit '/user_sessions/new'
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password

  click_button 'Log in'
  expect(page).to have_content 'Logout'
end
