require 'spec_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }
  describe '.save' do
    context "when valid attributes" do
      it 'should succeeds' do
        expect(subject.save).to eq(true)
      end
    end
  end

  describe '.save' do
    context "when invalid attributes" do
      it 'should succeeds' do
        user = FactoryBot.build(:user, :invalid)
        expect(user.save).to eq(false)
      end
    end
  end

  describe '.sync_on_remote!' do
    context 'when valid user' do
      xit 'should change the remote id attribute' do
        # TODO: Casset can record only ONE request, second gets lost
        VCR.use_cassette("get_users") do
          subject.sync_on_remote!
        end
        expect(subject.remote_id_was).to wont_be(subject.remote_id)
      end
    end
  end
end
