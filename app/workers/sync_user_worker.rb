class SyncUserWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    return unless user.remote_id.nil?
    user.sync_on_remote!
  end
end