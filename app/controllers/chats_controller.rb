class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @chats = current_user.chats.order(updated_at: :desc) if user_signed_in?
    @messages = @chat.messages
  end

  def new
    @chat = Chats::CreateChatService.new(user: current_user, session: session).call
    redirect_to chat_path(@chat)
  end
end
