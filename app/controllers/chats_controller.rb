class ChatsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]

  def show
    @chat = Chat.find(params[:id])
    @chats = current_user.chats.order(updated_at: :desc) if user_signed_in?
    @messages = @chat.messages
  end

  def new
    @chat = Chats::CreateChatService.new(user: current_user, session: session).call
    redirect_to chat_path(@chat)
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy

    if current_user.chats.any?
      redirect_to chat_path(current_user.chats.last)
    else
      redirect_to new_chat_path
    end
  end
end
