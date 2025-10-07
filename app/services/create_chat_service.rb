class Chats::CreateChatService
  def initialize(user:, session:)
    @user = user
    @session = session
  end

  def call
    chat = if @user
      @user.chats.create!
    else
      find_or_create_guest_chat
    end

    chat.messages.create!(sender: 'mia', content: I18n.t('messages.create.welcome_message')) if chat.messages.empty?
    chat
  end

  private

  def find_or_create_guest_chat
    if (chat_id = @session[:guest_chat_id])
      chat = Chat.find_by(session_token: chat_id)
      unless chat
        @session.delete(:guest_chat_id)
        chat = Chat.create!(session_token: SecureRandom.uuid)
      end
    else
      chat = Chat.create!(session_token: SecureRandom.uuid)
      @session[:guest_chat_id] = chat.session_token
    end

    chat
  end
end
