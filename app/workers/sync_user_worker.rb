require 'net/http'

class SyncUserWorker
  include Sidekiq::Worker

  def perform(first_name, last_name)
    unless user_exists(get_users, first_name, last_name)
      if (remote_user = post_user(first_name, last_name))
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

  def post_user(first_name, last_name)
    uri = URI('https://reqres.in/api/users?per_page=12')
    user = { first_name: first_name, last_name: last_name }
    res = Net::HTTP.post_form(uri, user)
    JSON.parse(res.body)
  end

  def user_exists(users, first_name, last_name)
    users.select do |user|
      user["first_name"] == first_name and user["last_name"] == last_name
    end
  end

end