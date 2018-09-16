require 'httparty'
require 'json'

class HttpClient
  class << self
    def get(url, params={})
      full_url = url + build_query_string(params)
      response = HTTParty.get(full_url)
      JSON.parse(response.body)
    end

    private

    def build_query_string(params)
      query = '?'
      params.each do |key, value|
        query += "#{key}=#{value}&"
      end
      query
    end
  end
end
