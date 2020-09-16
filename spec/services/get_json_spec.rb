require 'spec_helper'

RSpec.describe GetJson do
  let(:valid_url) { 'https://reqres.in/api/users' }
  let(:req) { GetJson.new valid_url }

  describe '.get' do
    context 'when params are valid' do
      it 'should return an Array' do
        VCR.use_cassette("get_users") do
          expect(req.get).to be_a Array
        end
      end
    end

    context 'when url is invalid' do
      it 'should return false' do
        VCR.use_cassette("invalid url") do
          req = GetJson.new 'https://r2eqres.in/api/users'
          expect(req.get).to eq(false)
        end
      end
    end

    context 'when url is empty' do
      it 'should raise ArgumentError' do
        VCR.use_cassette("invalid url") do
          req = GetJson.new ''
          expect { req.get }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
