class MessagePolicy < ApplicationPolicy
  def create?
    return true if user.present? && record.chat.user_id == user.id

    # Temporary session access for guest users
    return true if !user.present? && record.chat.user_id.nil?

    false
  end

  class Scope < Scope
    def resolve
      if user.present?
        scope.joins(:chat).where(chats: { user_id: user.id })
      elsif !user.present? && record.chat.user_id.nil?
        scope.joins(:chat).where(chats: { id: record.chat.id })
      else
        scope.none
      end
    end
  end
end
