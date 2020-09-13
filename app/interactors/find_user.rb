class FindUser
  include Interactor

  def call
    begin
      context.user = User.find(context.user_id)
    rescue ActiveRecord::RecordNotFound => e
      context.fail!(message: 'Usuário não encontrado.')
    end
  end
end
