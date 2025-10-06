class ChatController < ApplicationController
  protect_from_forgery with: :null_session, only: :create

  def index; end

  def create
    # For now, we return a static response. Replace this with actual OpenAI API call.
    ai_reply = "Hello! I'm Mia, your mental health assistant. How can I assist you today?"

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
end
