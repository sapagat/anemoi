require_relative 'directions_gateway'

DirectionsGateway.configure do |config|
  config.api_key = ENV['DIRECTIONS_API_KEY']
end
