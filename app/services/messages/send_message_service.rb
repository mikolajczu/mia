class Messages::SendMessageService
  def initialize(message:, chat:, user_signed_in:, content:)
    @message = message
    @chat = chat
    @user_signed_in = user_signed_in
    @content = content
  end

  def call
    return { error: I18n.t('messages.create.guest_message_limit') } if guest_chat_limit_reached?

    @message.save!

    # For now, we return a static response. Replace this with actual OpenAI API call.
    ai_reply = Faker::Lorem.sentence(word_count: 15)
    @chat.messages.create!(sender: 'mia', content: ai_reply)

    # Simulate processing delay
    sleep(2)

    # Uncomment and configure the OpenAI client when ready to use the API
    # client = OpenAI::Client.new(access_token: ENV.fetch['OPENAI_API_KEY', nil])

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

    { reply: ai_reply }
  end

  private

  def guest_chat_limit_reached?
    !@user_signed_in && @chat.messages.where(sender: 'user').count >= 10
  end
end
