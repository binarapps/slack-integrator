class User < Sequel::Model
  plugin :secure_password
  plugin :validation_helpers

  def validate
    super
    validates_unique :email
    errors.add(:email, 'must be present') if !email || email.empty?
  end
end
