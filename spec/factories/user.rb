FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    github_login { Faker::Internet.user_name }
    password 'password'
    password_confirmation 'password'
  end
end
