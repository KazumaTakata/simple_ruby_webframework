# frozen_string_literal: true

require 'yaml'
require 'rack'
require 'thin'
ROUTES = YAML.safe_load(File.read(File.join(File.dirname(__FILE__), 'app', 'routes.yml')))

require './lib/router'

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end
end

Rack::Handler::Thin.run(App.new, Port: 3000)
