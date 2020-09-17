require 'spec_helper'

RSpec.describe DestroyUser, type: :interactor do
  describe '.call' do
    let (:user) { FactoryBot.build(:user) }
    subject(:context) { DestroyUser.call(user: user) }

    context "when given a user" do
      it "succeeds" do
        expect(context).to be_a_success
      end
    end

    context "when missing user" do
      let (:context) { DestroyUser.call(user: nil) }
      it "should fail" do
        expect(context).to be_a_failure
      end
    end
  end
end
