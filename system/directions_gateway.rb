require_relative 'http_client'
require_relative 'configurable'

class DirectionsGateway
  include Configurable

  configure_with :api_key

  class << self
    def fetch(origin, destination)
      directions = HttpClient.get(api_url, build_params(origin, destination))
      response = Response.new(directions)

      {
        target: response.target,
        steps: response.steps
      }
    end

    private

    def api_url
      base_url + endpoint
    end

    def base_url
      'https://maps.googleapis.com'
    end

    def endpoint
      '/maps/api/directions/json'
    end

    def build_params(origin, destination)
      {
        origin: origin.gsub(' ', '+'),
        destination: destination.gsub(' ', '+'),
        mode: 'walking',
        key: api_key
      }
    end

    def api_key
      raise 'Api key missing!' unless configuration.api_key

      configuration.api_key
    end

    class Response
      def initialize(data)
        @data = data
      end

      def target
        "#{the_route['end_address']} (#{the_route['distance']['text']})"
      end

      def steps
        the_route['steps'].map do |step|
          html_tag_pattern = /<("[^"]*"|'[^']*'|[^'">])*>/
          instruction = step['html_instructions'].gsub(html_tag_pattern, '')
          "#{instruction} (#{step['distance']['text']})"
        end
      end

      private

      def the_route
        @data['routes'].first['legs'].first
      end
    end
  end
end
