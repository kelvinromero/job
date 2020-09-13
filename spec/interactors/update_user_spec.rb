require 'spec_helper'

RSpec.describe UpdateUser, type: :interactor do
  describe '.call' do
    let (:user) { CreateUser.call(user_params: {first_name: "John", last_name: "Wick"}).user }
    subject(:context) { UpdateUser.call(user: user, user_params: {first_name: "Keanu", last_name: "Reeves"}) }

    context "when given a user and user_params" do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it "should contain a user" do
        expect(context.user.class).to eq(User)
      end

      it "user should have updated first name" do
        expect(context.user.first_name).to eq("Keanu")
      end

      it "user should have updated last name" do
        expect(context.user.last_name).to eq("Reeves")
      end
    end

  end
end
