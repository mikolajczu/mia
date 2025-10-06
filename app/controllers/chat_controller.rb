class ChatController < ApplicationController
  before_action :find_or_create_chat

  def index
    @messages = @chat.messages
  end

  def create
    return render json: { reply: I18n.t('chat.index.guest_message_limit') } if guest_chat_limit_reached?

    @chat.messages.create!(sender: 'user', content: params[:message])

    # For now, we return a static response. Replace this with actual OpenAI API call.
    ai_reply = I18n.t('chat.index.welcome_message')
    @chat.messages.create!(sender: 'mia', content: ai_reply)

    # Simulate processing delay
    sleep(2)

    # Uncomment and configure the OpenAI client when ready to use the API
    # client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

    # response = client.chat(
    #   parameters: {
    #     model: 'gpt-4o',
    #     messages: [
    #       { role: 'system', content: 'You are Mia, a supportive AI wellbeing assistant.' },
    #       { role: 'user', content: params[:message] }
    #     ]
    #   }
    # )

    # ai_reply = response.dig('choices', 0, 'message', 'content')
    render json: { reply: ai_reply }
  end

  private

  def find_or_create_chat
    if user_signed_in?
      @chat = current_user.chats.last || current_user.chats.create!
    else
      session[:guest_chat_id] ||= SecureRandom.uuid
      @chat = Chat.find_or_create_by(session_token: session[:guest_chat_id])
    end

    return unless @chat.messages.empty?

    @chat.messages.create!(
      sender: 'mia',
      content: I18n.t('chat.index.welcome_message')
    )
  end

  def guest_chat_limit_reached?
    !user_signed_in? && @chat.messages.where(sender: 'user').count >= 10
  end
end
