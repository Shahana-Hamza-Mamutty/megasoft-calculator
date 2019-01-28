module Megasoft
  module Admin
    class BaseController < ApplicationController

      http_basic_authenticate_with name: ENV['ADMIN_AUTHENTICATION_USERNAME'], password: ENV['ADMIN_AUTHENTICATION_PASSWORD']

    end
  end
end