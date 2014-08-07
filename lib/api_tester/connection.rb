require 'faraday'
require 'json'

module ApiTester
  class Connection

    def initialize(endpoint, options = {})
      @endpoint = endpoint
    end

    def connection
      @conn ||= Faraday.new(:url => @endpoint) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def headers
      'application/json'
    end

    def post(api, body)
      resp = connection.post do |req|
        req.url api
        req.headers['Content-Type'] = headers
        req.body = body
      end
    end

    def pretty_print(resp)
      puts JSON.pretty_generate(JSON.parse(resp.body))
    end
  end
end
