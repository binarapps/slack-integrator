def production?
  ENV.fetch('RACK_ENV') == 'production'
end

def test?
  ENV.fetch('RACK_ENV') == 'test'
end

def current_user
  env['warden'].user
end

def user_signed_in?
  current_user.nil?
end

def api_request?
  lambda {|request| request.env['PATH_INFO'].start_with?('/api') }
end
