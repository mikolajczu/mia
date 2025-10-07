class ChatPolicy < ApplicationPolicy
  def show?
    return true if user.present? && record.user_id == user.id

    # Temporary session access for guest users
    return true if !user.present? && record.user_id.nil?

    false
  end

  def new?
    true
  end

  def destroy?
    user.present? && record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.present?
        scope.where(user_id: user.id)
      elsif !user.present? && record.user_id.nil?
        scope.where(id: record.id)
      else
        scope.none
      end
    end
  end
end
