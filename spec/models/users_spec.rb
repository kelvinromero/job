require 'spec_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }
  describe '.save' do
    context 'with valid attributes' do
      it 'should succeeds' do
        expect(subject.save).to eq(true)
      end
    end

    context 'with invalid attributes' do
      user = FactoryBot.build(:user, :invalid)

      it 'should succeeds' do
        expect(user.save).to eq(false)
      end

      it 'should raise exception' do
        expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with empty' do
      context 'first_name' do
        user = FactoryBot.build(:user, first_name: '   ')
        it 'should raise exception ' do
          expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'last_name' do
        user = FactoryBot.build(:user, last_name: '   ')
        it 'should raise exception ' do
          expect{ user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe '.sync_on_remote!' do
    it 'remote_id not should be nil' do
      VCR.use_cassette("get_users_and_user") do
        subject.sync_on_remote!
      end
      expect(subject.remote_id).to_not be(nil)
    end
  end
end
