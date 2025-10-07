FactoryBot.define do
  factory :chat do
    user { nil }
    session_token { SecureRandom.uuid }
  end
end
