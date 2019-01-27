require 'rails_helper'

RSpec.describe Megasoft::Api::V1::CalculatorController, type: :request do
  describe 'POST /megasoft/api/v1/calculator/calculate' do

    context "Basic authentication and validation" do
      it 'should return 401 UNAUTHORIZED' do
        request_data = {input: '1,2,3,4', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=aym-te$SSQWQXT"}
        expect(response).to have_http_status(401)
      end

      it 'should return return error message if unauthorised ' do
        request_data = {input: '1,2,3,4', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=aym-te$SSQWQXT"}
        expect(JSON.parse(response.body)['message']).to eq 'You are unauthorized to perform this action'
      end

      it "should return error when input is empty" do
        request_data = {input: '', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid request'
      end

    end

    context "Add operator" do
      before :each do
        @operator = FactoryGirl.create(:add)
      end

      it 'should return 201' do
        request_data = {input: '1,2,3,4', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should add all the input data" do
        request_data = {input: '1,2,3,4', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 10
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return error message if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return total for float inout" do
        request_data = {input: '1.4,9.3,444444,5', operation: '+' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 444459.7
      end

    end

    context "Subtract operator" do
      before :each do
        @operator = FactoryGirl.create(:subtract)
      end

      it 'should return 201' do
        request_data = {input: '1,2', operation: '-' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '1,2', operation: '-' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq -1
      end

      it "should return correct result if its mix of positive and negative numbers" do
        request_data = {input: '-1,2', operation: '-' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq -3
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '1,3123dsad4', operation: '-' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return error message if input contains string" do
        request_data = {input: '1,3123dsad4', operation: '-' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return total for float inout" do
        request_data = {input: '1.4,-89769.3', operation: '-' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 89770.7
      end

    end

    context "Multiply operator" do
      before :each do
        @operator = FactoryGirl.create(:multiply)
      end

      it 'should return 201' do
        request_data = {input: '1,2,3,4', operation: '*' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '1,2,3,4', operation: '*' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 24
      end

      it "should return correct result if its mix of positive and negative numbers" do
        request_data = {input: '1,2,-3,-4', operation: '*' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 24
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '*' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return error message if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '*' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return total for float input" do
        request_data = {input: '1.4,-89769.3,444444,5,-9', operation: '*' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 2513537886459.5996
      end

    end

    context "Divide operator" do
      before :each do
        @operator = FactoryGirl.create(:divide)
      end

      it 'should return 201' do
        request_data = {input: '1,2', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '1,2', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 0.5
      end

      it "should raise error if inout length is greater than 2" do
        request_data = {input: '1,2,3,4', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return correct result if its mix of positive and negative numbers" do
        request_data = {input: '1,-2', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq -0.5
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return error message if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return total for float input" do
        request_data = {input: '1.4,-89769.3', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq -1.559553210284585e-05
      end

      it "should return error when divided by zero" do
        request_data = {input: '1.4,0', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error with single input" do
        request_data = {input: '1.4', operation: '/' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

    end

    context "Cuberoot operator" do
      before :each do
        @operator = FactoryGirl.create(:cube_root)
      end

      it 'should return 201' do
        request_data = {input: '12', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '12', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 2.2894284851066637
      end

      it "should raise error if inout length is greater than 1" do
        request_data = {input: '1,2,3,4', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return correct result if its a negative number" do
        request_data = {input: '-2', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq -1.2599210498948732
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '23dadas', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return error message if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return valid output for float input" do
        request_data = {input: '1.4', operation: 'cbrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 1.1186889420813968
      end

    end

    context "Cuberoot operator" do
      before :each do
        @operator = FactoryGirl.create(:square_root)
      end

      it 'should return 201' do
        request_data = {input: '12', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '12', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 3.4641016151377544
      end

      it "should raise error if inout length is greater than 1" do
        request_data = {input: '1,2,3,4', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error if input is negative" do
        request_data = {input: '-2', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '23dadas', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return err or message if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return valid output for float input" do
        request_data = {input: '1.4', operation: 'sqrt' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 1.1832159566199232
      end

    end

    context "Factorial operator" do
      before :each do
        @operator = FactoryGirl.create(:factorial)
      end

      it 'should return 201' do
        request_data = {input: '12', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '12', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 479001600.0
      end

      it "should raise error if inout length is greater than 1" do
        request_data = {input: '1,2,3,4', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error if input is negative" do
        request_data = {input: '-2', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '23dadas', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return err or message if input contains string" do
        request_data = {input: '1,2,3123dsad4', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return valid output for float input" do
        request_data = {input: '1.4', operation: '!' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 1.2421693445043054
      end

    end

    context "Power operator" do
      before :each do
        @operator = FactoryGirl.create(:power)
      end

      it 'should return 201' do
        request_data = {input: '12,7', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(201)
      end

      it "should return correct result if all are positive numbers" do
        request_data = {input: '12,7', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 35831808.0
      end

      it "should raise error if input length is greater than 2" do
        request_data = {input: '1,2,3,4', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error if input is less than two numbers" do
        request_data = {input: '2', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return error status 400 if input contains string" do
        request_data = {input: '23dadas', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(response).to have_http_status(400)
      end

      it "should return err or message if input contains string" do
        request_data = {input: '2,3123dsad4', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['message']).to eq 'Invalid input'
      end

      it "should return valid output for float input" do
        request_data = {input: '1.4, 4.5', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 4.545442418951096
      end

      it "should return valid output for power of negative" do
        request_data = {input: '1.4, -17', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq 0.0032796189977337066
      end

      it "should return valid output for both negative inputs" do
        request_data = {input: '-1.4, -17', operation: '^' }
        post "/megasoft/api/v1/calculator/calculate", params: request_data, headers: {'Authorization' => "Token token=#{ENV['API_AUTHENTICATION_TOKEN']}"}
        expect(JSON.parse(response.body)['result']).to eq -0.0032796189977337066
      end

    end

  end
end
