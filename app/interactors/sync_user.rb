class SyncUser
  include Interactor

  def call
    SyncUserWorker.perform_async(context.user.id)
  end
end
