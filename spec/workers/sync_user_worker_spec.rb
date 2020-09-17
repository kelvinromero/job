require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SyncUserWorker, type: :worker do
  it "job in correct queue" do
    described_class.perform_async
    assert_equal :user_sync, described_class.queue
  end

  context 'when invoked' do
    it 'should change job count' do
      expect { described_class.perform_async(1, 2) }.to change(described_class.jobs, :size).by(1)
    end
  end
end
