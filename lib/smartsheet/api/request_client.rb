require 'smartsheet/version'
require 'smartsheet/error'

module Smartsheet
  module API
    # Composes {EndpointSpec endpoint specifications} and {RequestSpec request specifications} to
    # form a single {Request} that it submits to the provided client
    class RequestClient
      def initialize(
          token,
          client,
          base_url,
          app_user_agent: nil,
          assume_user: nil,
          logger: MuteRequestLogger.new
      )
        @token = token
        @client = client
        @app_user_agent = app_user_agent
        @assume_user = assume_user
        @logger = logger
        @base_url = base_url
      end

      def make_request(endpoint_spec, request_spec)
        request = Request.new(
          token,
          endpoint_spec,
          request_spec,
          base_url,
          app_user_agent: app_user_agent,
          assume_user: assume_user
        )

        logger.log_request(request)
        client.make_request(request)
      end

      private

      attr_reader :token, :client, :app_user_agent, :assume_user, :logger, :base_url
    end
  end
end