class CreateUser
  include Interactor

  def call
    context.user = User.create!(context.user_params)
  end
end
