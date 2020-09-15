class User < ApplicationRecord

  def sync_on_remote!
    return unless (users = get_users)
    return if user_exists_on_remote(users, self)

    if (remote_user = post_user(self))
      self.remote_id = remote_user["id"]
      self.save!
    end
  end

  private
  # TODO: Move API calls to services (Or interactors maybe
  # )
  def get_users
    begin
      uri = URI('https://reqres.in/api/users?per_page=12')
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)['data']
    rescue SocketError
      return false
    end
  end

  def post_user(local_user)
    begin
      uri = URI('https://reqres.in/api/users')
      user = { first_name: local_user.first_name, last_name: local_user.last_name }
      res = Net::HTTP.post_form(uri, user)
      JSON.parse(res.body)
    rescue SocketError
      return false
    end
  end

  def user_exists_on_remote(users, local_user)
    users.select { |user| user["first_name"] == local_user.first_name and user["last_name"] == local_user.last_name }.any?
  end
end
