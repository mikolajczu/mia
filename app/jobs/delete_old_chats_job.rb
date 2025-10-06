class DeleteOldChatsJob
  include Sidekiq::Job

  sidekiq_options retry: false

  def perform
    Chat.where(user_id: nil)
        .where('created_at < ?', 24.hours.ago)
        .destroy_all
  end
end
