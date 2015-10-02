FactoryGirl.define do
  factory :user do
    email 'email@example.com'
    password 'password'
    password_confirmation 'password'
  end
end
