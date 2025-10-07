FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'Password!' }
  end
end
