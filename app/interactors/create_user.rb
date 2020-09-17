class CreateUser
  include Interactor

  def call
    begin
      context.user = User.create!(context.user_params)
    rescue ActiveRecord::RecordInvalid => e
      context.fail!(message: e)
    end
  end
end
