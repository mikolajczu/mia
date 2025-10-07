require 'rails_helper'

RSpec.describe Chat, type: :model do
  it 'is valid with a user' do
    chat = build(:chat, user: create(:user))
    expect(chat).to be_valid
  end

  it 'is valid with a session token for guest' do
    chat = build(:chat, session_token: SecureRandom.uuid)
    expect(chat).to be_valid
  end

  it 'is invalid without user or session token' do
    chat = build(:chat, user: nil, session_token: nil)
    expect(chat).not_to be_valid
  end

  it 'requires unique session_token' do
    token = SecureRandom.uuid
    create(:chat, session_token: token)
    dup_chat = build(:chat, session_token: token)
    expect(dup_chat).not_to be_valid
  end
end
