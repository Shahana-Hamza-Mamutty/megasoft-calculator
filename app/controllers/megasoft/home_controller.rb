module Megasoft
  class HomeController < ApplicationController

  	def index
  		@operators = {}
  		Operator.all.map{|d| @operators[d.position] = {display_sign: d.display_sign, action: d.action} }
  	end

  end
end