class UpdateUser
  include Interactor

  def call
    context.user.update!(context.user_params)
  end
end
