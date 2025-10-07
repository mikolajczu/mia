require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:chat) { create(:chat, session_token: SecureRandom.uuid) }

  it 'is valid with sender and content' do
    message = build(:message, chat: chat, sender: 'mia', content: 'Hello!')
    expect(message).to be_valid
  end

  it 'is invalid without sender' do
    message = build(:message, chat: chat, sender: nil, content: 'Hi!')
    expect(message).not_to be_valid
  end

  it 'is invalid with too long content' do
    message = build(:message, chat: chat, sender: 'user', content: 'a' * 1001)
    expect(message).not_to be_valid
  end

  it 'only allows senders "user" or "mia"' do
    message = build(:message, chat: chat, sender: 'bot', content: 'Hello!')
    expect(message).not_to be_valid
  end
end
