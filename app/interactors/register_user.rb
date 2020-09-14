class RegisterUser
  include Interactor::Organizer

  organize CreateUser, SyncUser
end
