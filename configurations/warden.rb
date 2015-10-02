# config/warden.rb
require 'warden'

Warden::Manager.serialize_into_session{|user| user.id }
Warden::Manager.serialize_from_session{|id| User[id] }

Warden::Strategies.add(:password) do
  def valid?
    params["email"] || params["password"]
  end

  def authenticate!
    user = User.first(email: params["email"])
    if user && user.authenticate(params["password"])
      success! user
    else
      redirect!('/user_sessions/new')
    end
  end
end
