class User < ApplicationRecord

  validates_presence_of :first_name, :last_name
  validates :first_name, :last_name, length: { minimum: 1, allow_nil: false}

  REMOTE_USERS_URL = 'https://reqres.in/api/users'

  def sync_on_remote!
    return unless (users = GetJson.new(REMOTE_USERS_URL).get)
    return if user_exists_on_remote(users, self)

    json = self.as_json(only: [:first_name, :last_name])
    remote_user = PostJson.new(REMOTE_USERS_URL, json).post

    if remote_user
      self.remote_id = remote_user["id"]
      self.save!
    end
  end

  private
  def user_exists_on_remote(users, local_user)
    users = users.select do |user|
      user["first_name"] == local_user.first_name and user["last_name"] == local_user.last_name
    end

    users.any?
  end

end
