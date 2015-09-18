FactoryGirl.define do
  factory :reservation do
    reserved_at Date.today
    from  "11"
    to "12"
  end
end
