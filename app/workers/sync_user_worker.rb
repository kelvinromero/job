class SyncUserWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :user_sync

  def perform(user_id)
    user = User.find(user_id)
    return unless user.remote_id.nil?
    user.sync_on_remote!
  end
end