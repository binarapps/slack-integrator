class RegisterUser

  def call(params)
    User.create(email: params['email'],
                password: params['password'],
                password_confirmation: params['password_confirmation'])
  end
end
