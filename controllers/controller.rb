# frozen_string_literal: true

class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action # 1
  end

  def call
    send(action) # 2
    self.status = 200 # 3
    self.headers = { 'Content-Type' => 'text/html' }
    self.content = ['Hello world']
    self
  end

  def not_found # 4
    self.status = 404
    self.headers = {}
    self.content = ['Nothing found']
    self
  end

  def internal_error # 5
    self.status = 500
    self.headers = {}
    self.content = ['Internal error']
    self
  end
end
