# frozen_string_literal: true

require_relative '../controllers/main_controller'
require 'pry'
class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(env)
    binding.pry
    path = env['REQUEST_PATH']
    if routes.key?(path)
      ctrl(routes[path]).call
    else
      Controller.new.not_found
     end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error
  end

  private def ctrl(string)
    ctrl_name, action_name = string.split('#')
    klass = Object.const_get "#{ctrl_name.capitalize}Controller"
    klass.new(name: ctrl_name, action: action_name.to_sym)
  end
end
