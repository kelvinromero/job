class SyncUser
  include Interactor

  def call
    SyncUserWorker.perform_in(5.seconds,
                              context.user.first_name,
                              context.user.last_name )
  end
end
