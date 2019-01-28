module Megasoft
  module Api
    module V1
      class BaseController < ApplicationController
        include ActionController::HttpAuthentication::Token::ControllerMethods
        skip_before_action :verify_authenticity_token

        before_action :authenticate

        protected

        # Authenticate the user with token based authentication
        def authenticate
          authenticate_token || render_unauthorized
        end

        def authenticate_token
          authenticate_with_http_token do |token, options|
            token == ENV['API_AUTHENTICATION_TOKEN']
          end
        end

        def render_unauthorized
          render json: {message: "You are unauthorized to perform this action"}, status: 401
        end

      end
    end
  end
end
