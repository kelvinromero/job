class CreateUser
  include Interactor

  def call
    context.user = User.create(context.user_params)

    if (context.user.errors.any?)
      context.fail!
    end
  end
end
