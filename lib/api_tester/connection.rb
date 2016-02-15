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
        faraday.response :logger if ApiTester.configuration.options[:verbose]
        faraday.adapter  Faraday.default_adapter
      end
    end

    [:post, :get, :put, :delete].each do |method|
      define_method "#{method}" do |api, body, params = nil, header = nil|
        connection.send("#{method}") do |req|
          req.url api, params
          req.options.timeout = 3600
          req.options.open_timeout = 3600
          req.body = body.to_json if body
          req.headers = header.nil? ? header_json : header_json.merge(header)
        end
      end
    end

    def pretty_print(resp)
      begin
        puts JSON.pretty_generate(JSON.parse(resp.body))
      rescue
        puts resp.body
      end
    end

    private

    def header_json
      {
        'User-Agent'        => 'Api Tester',
        'Content-Type'      => 'application/json'
      }
    end
  end
end
