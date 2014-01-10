module Wonga
  module Daemon
    class PantryJenkinsSlaveDeletedEventHandler
      def initialize(api_client, logger)
        @logger = logger
        @api_client = api_client
      end

      def handle_message(message)
        @logger.info "Updating deleted status for Jenkins slave: #{message['server_ip']}"
        message[:removed] = true
        @api_client.send_put_request("/api/jenkins_slaves/#{message['jenkins_slave_id']}", message)
      end
    end
  end
end
