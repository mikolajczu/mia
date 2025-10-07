class Chat < ApplicationRecord
  belongs_to :user, optional: true
  has_many :messages, dependent: :destroy

  validates :session_token, uniqueness: true, allow_nil: true
  validate :either_user_or_session_token_present

  private

  def either_user_or_session_token_present
    errors.add(:base, I18n.t('either_user_or_session_token_present')) unless user_id.present? || session_token.present?
  end
end
