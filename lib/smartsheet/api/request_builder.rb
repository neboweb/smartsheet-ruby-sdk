require_relative 'urls'
require_relative 'headers'

module Smartsheet
  module API
    class RequestBuilder
      def initialize(token, endpoint_spec, request_spec, req)
        @token = token
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
        @req = req
      end

      def apply
        build_url
        build_headers
        build_params
        build_body
      end

      private

      attr_reader :token, :endpoint_spec, :request_spec, :req

      def build_url
        url = Smartsheet::API::UrlBuilder.new(endpoint_spec, request_spec).build

        req.url(url)
      end

      def build_headers
        req.headers = Smartsheet::API::HeaderBuilder.new(token, endpoint_spec, request_spec).build
      end

      def build_params
        req.params = request_spec.params
      end

      def build_body
        req.body = request_spec.body if request_spec.body
      end
    end
  end
end