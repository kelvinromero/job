require 'spec_helper'

RSpec.describe CreateUser, type: :interactor do
  describe '.call' do
    subject(:context) { CreateUser.call(user_params: {first_name: "John", last_name: "Wick"}) }

    context "when given user_params" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "should contain a user" do
        expect(context.user.class).to eq(User)
      end

      it "user should have first name" do
        expect(context.user.first_name).to eq("John")
      end

      it "user should have last name" do
        expect(context.user.last_name).to eq("Wick")
      end
    end

    context 'when given invalid user params' do
      let (:invalid_params) { FactoryBot.build(:user_params, :invalid) }
      let (:context) { CreateUser.call(user_params: invalid_params) }

      it 'fails' do
        expect(context).to be_a_failure
      end
    end
  end
end
