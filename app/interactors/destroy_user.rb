class DestroyUser
  include Interactor

  def call
    begin
      context.user.destroy!
    rescue NoMethodError => e
      context.fail!(message: e)
    end
  end
end
