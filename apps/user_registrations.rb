RodaApp.route('user_registrations') do |r|
  r.post 'create' do
    begin
      RegisterUser.new(r.params).call
    rescue Sequel::ValidationFailed, UnauthorizedUser => e
      flash[:error] = "Errors occured"
      r.redirect '/user_registrations/new'
    end
    r.redirect '/user_sessions/new'
  end

  r.get 'new' do
    view('/user_registrations/new')
  end

end
