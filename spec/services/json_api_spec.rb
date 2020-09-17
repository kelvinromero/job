require 'spec_helper'

RSpec.describe JsonApi do
  let(:valid_url) { 'https://reqres.in/api/users' }
  let(:valid_data) { FactoryBot.build(:user).as_json(only: [:first_name, :last_name]) }
  subject { JsonApi.new valid_url, valid_data}

  describe '.get' do
    context 'when params are valid' do
      it 'should return an Array' do
        VCR.use_cassette("get_users") do
          expect(subject.get).to be_a Array
        end
      end
    end

    context 'when url is invalid' do
      it 'should return false' do
        VCR.use_cassette("invalid_data") do
          req = JsonApi.new 'https://r2eqres.in/api/users'
          expect(req.get).to eq(false)
        end
      end
    end

    context 'when url is empty' do
      it 'should raise ArgumentError' do
        VCR.use_cassette("invalid_data") do
          req = JsonApi.new ''
          expect { req.get }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '.post' do

    context 'when params are valid' do
      it 'should return a hash' do
        VCR.use_cassette("user") do
          expect(subject.post).to be_a Hash
        end
      end
    end

    context 'when url is invalid' do
      it 'should return false' do
        VCR.use_cassette("invalid_data") do
          req = JsonApi.new 'https://r2eqres.in/api/users', valid_data
          expect(req.post).to eq(false)
        end
      end
    end

    context 'when url is empty' do
      it 'should raise ArgumentError' do
        VCR.use_cassette("invalid_data") do
          req = JsonApi.new '', valid_data
          expect { req.post }.to raise_error(ArgumentError)
        end
      end
    end

    context 'with invalid data' do
      it 'should raise ArgumentError' do
        VCR.use_cassette("invalid data") do
          req = JsonApi.new valid_url, ''
          expect { req.post }.to raise_error(ArgumentError)
        end
      end
    end

    context 'with empty data' do
      it 'should raise ArgumentError' do
        VCR.use_cassette("invalid data") do
          req = JsonApi.new valid_url, {}
          expect { req.post }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
