class MessagesController < ApplicationController
  before_action :set_chat

  def create
    message = authorize Message.new(chat: @chat, sender: 'user', content: params[:message])
    result = Messages::SendMessageService.new(
      message: message,
      chat: @chat,
      user_signed_in: user_signed_in?,
      content: params[:message]
    ).call

    if result[:error]
      render json: { reply: I18n.t('messages.create.error') }
    else
      render json: { reply: result[:reply] }
    end
  end

  private

  def set_chat
    if user_signed_in?
      @chat = current_user.chats.find(params[:chat_id])
    else
      @chat = Chat.find_by(session_token: session[:guest_chat_id])
      render json: { error: 'Chat not found' }, status: :not_found unless @chat
    end
  end
end
