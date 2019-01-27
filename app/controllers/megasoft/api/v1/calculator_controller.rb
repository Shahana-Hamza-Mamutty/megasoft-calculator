module Megasoft
  module Api
  	module V1
	    class CalculatorController < BaseController

	    	def calculate
	    		operator = Operator.find_by_action calculator_params[:operation]
	    		if operator && calculator_params[:input].present?
	    			begin
	    				result = operator.calculate(calculator_params[:input])
	    				render json: { result: result }, status: 201
	    			rescue Exception => e
	    				render json: { message: e.message } , status: :bad_request
	    			end
	    		else
	    			render json: { message: "Invalid request" } , status: :bad_request
	    		end
	    	end

	    	private

	    	def calculator_params
	    		params.permit(:operation, :input)
	    	end
	    end
	  end
  end
end