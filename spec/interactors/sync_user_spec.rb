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
  end
end
