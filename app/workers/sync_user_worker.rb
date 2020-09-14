require 'net/http'

class SyncUserWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default , :retry => 1

  def perform(user_id)
    local_user = User.find(user_id)

    unless user_exists(get_users, local_user)
      if (remote_user = post_user(local_user))
        remote_user
      end
    end
  end

  private
  def get_users
    uri = URI('https://reqres.in/api/users?per_page=12')
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)['data']
  end

  def post_user(local_user)
    uri = URI('https://reqres.in/api/users?per_page=12')
    user = { first_name: local_user.first_name, last_name: local_user.last_name }
    res = Net::HTTP.post_form(uri, user)
    JSON.parse(res.body)
  end

  def user_exists(users, local_user)
    users.select do |user|
      user["first_name"] == local_user.first_name and user["last_name"] == local_user.last_name
    end
  end

end