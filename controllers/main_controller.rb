# frozen_string_literal: true

require_relative './controller.rb'
# app/controllers/main_controller.rb
class MainController < Controller
  def index
    @test = 'Some dump text here'
    @arr = %w[one two three]
  end
end
