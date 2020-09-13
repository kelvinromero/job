require 'spec_helper'

RSpec.describe DestroyUser, type: :interactor do
  describe '.call' do
    let (:user) { CreateUser.call(user_params: {first_name: "John", last_name: "Wick"}) }
    subject(:context) { DestroyUser.call(user: user) }

    context "when given a user" do
      it "succeeds" do
        expect(context).to be_a_success
      end
    end
  end
end
