require 'uri'
require 'net/http'

module Transport

  # Common transport layer for http transfers.
  class HTTP
    include Common

    autoload :RequestBuilder, File.join(File.dirname(__FILE__), "http", "request_builder")

    def perform
      perform_request
      check_status_code
    end

    private

    def perform_request
      @response = Net::HTTP.start(@uri.host, @uri.port) do |connection|
        connection.request @request
      end
    end

    def check_status_code
      expected_status_code = @options[:expected_status_code]
      return unless expected_status_code
      response_code = @response.code.to_i
      response_body = @response.body
      raise UnexpectedStatusCodeError.new(response_code, response_body) if expected_status_code.to_i != response_code
    end

  end

end
