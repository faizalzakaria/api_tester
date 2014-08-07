require 'api_tester/connection'

module ApiTester

  class Configuration
    attr_accessor :endpoint, :options

    def initialize
      @endpoint = 'http://example.com'
      @options = {}
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.post(api, body)
    puts api
    resp = connection.post(api, body)
    connection.pretty_print(resp)
  end

  def self.connection
    @connection ||= Connection.new(configuration.endpoint, configuration.options)
  end

end
