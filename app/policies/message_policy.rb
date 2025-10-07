class MessagePolicy < ApplicationPolicy
  def create?
    return true if user.present? && record.chat.user_id == user.id

    # Temporary session access for guest users
    return true unless user.present?

    false
  end

  class Scope < Scope
    def resolve
      if user.present?
        scope.joins(:chat).where(chats: { user_id: user.id })
      elsif !user.present?
        scope.joins(:chat).where(chats: { id: record.chat.id }) # Placeholder condition for guest users
      else
        scope.none
      end
    end
  end
end
