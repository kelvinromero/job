require 'spec_helper'

RSpec.describe FindUser, type: :interactor do
  describe '.call' do
    let (:user) { CreateUser.call(user_params: {first_name: "John", last_name: "Wick"}).user }

    context "when given an user id" do
      context "that exists" do
        it "should return the user" do
          expect(FindUser.call(user_id: user.id).user).to eq(user)
        end
      end

      context "that doesn't exist" do
        it "should return nil" do
          not_id =  ([*1..100] - [user.id]).sample
          expect(FindUser.call(user_id: not_id).user).to eq(nil)
        end
      end
    end

  end
end
