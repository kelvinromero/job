class SyncUser
  include Interactor

  def call
    SyncUserWorker.perform_in(1.seconds, context.user.id)
  end
end
