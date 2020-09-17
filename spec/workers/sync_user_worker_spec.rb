require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SyncUserWorker, type: :worker do
  it "job in correct queue" do
    described_class.perform_async
    assert_equal :user_sync, described_class.queue
  end
end
