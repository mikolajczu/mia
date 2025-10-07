FactoryBot.define do
  factory :message do
    association :chat
    sender { 'mia' }
    content { 'Hello there!' }
  end
end
