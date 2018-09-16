require 'sinatra'
require_relative 'controller'

class Dispatcher
  def self.app
    Rack::Builder.app do
      map '/' do
        run Controller
      end

      map '//' do
        run Proc.new { |env| ['200', {'Content-Type' => 'text/plain'}, ['Hello, I\'m Anemoi']]}
      end
    end
  end
end
