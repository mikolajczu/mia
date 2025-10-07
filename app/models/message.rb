class Message < ApplicationRecord
  belongs_to :chat

  validates :sender, presence: true, inclusion: { in: %w[user mia] }
  validates :content, presence: true, length: { maximum: 1000 }
end
