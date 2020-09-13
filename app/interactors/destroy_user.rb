class DestroyUser
  include Interactor

  def call
    begin
      context.user.destroy!
    rescue => e
      context.fail!(message: "Ocorreu um erro na remoção do usuári e este foi reportado e será corrigido.")
    end
  end
end
