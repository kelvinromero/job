require 'spec_helper'

RSpec.describe SyncUser, type: :interactor do
  let (:user) { FactoryBot.build(:user) }
  subject {SyncUser.call(user: user)}

  describe '.call' do
    context 'when context has user' do
      it 'should be a success' do
        expect(subject).to be_a_success
      end
    end

    # TODO: Maybe it can be a shared example, it behaves like SyncUserWorker
    context 'when invoked' do
      it 'should change job count' do
        expect { subject.call }.to change(SyncUserWorker.jobs, :size).by(1)
      end
    end
  end
end
