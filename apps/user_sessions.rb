RodaApp.route('user_sessions') do |r|
  r.post 'create' do
    env['warden'].authenticate!

    r.redirect session[:return_to] || '/'
  end

  r.get 'unauthenticated' do
    view('/user_sessions/new')
  end

  r.get 'new' do
    view('/user_sessions/new')
  end

  r.post 'logout' do
    env['warden'].logout

    view('/user_sessions/new')
  end
end
