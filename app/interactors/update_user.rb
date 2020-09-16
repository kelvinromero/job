class UpdateUser
  include Interactor

  def call
    begin
      context.user.update!(context.user_params)
    rescue ActiveRecord::RecordInvalid => e
      context.fail!(message: e)
    end
  end
end
