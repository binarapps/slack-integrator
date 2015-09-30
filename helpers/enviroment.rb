def production?
  ENV.fetch('RACK_ENV') == 'production'
end

def current_user
  env['warden'].user
end

def user_signed_in?
  current_user.nil?
end
