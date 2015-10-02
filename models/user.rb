class User < Sequel::Model
  plugin :secure_password
  plugin :validation_helpers

  alias_method :save!, :save

  def validate
    super
    validates_unique :email
    errors.add(:email, 'must be present') if !email || email.empty?
  end
end
