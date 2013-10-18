module Wonga
  module Daemon
    class PantryJenkinsSlaveDeletedEventHandler
      def initialize(api_client, logger)
        @logger = logger
        @api_client = api_client
      end

      def handle_message(message)
        @logger.info "Updating deleted status for Jenkins slave: #{message['server_ip']}"
        @api_client.send_put_request("/api/jenkins_slaves/#{message['id']}", { removed: true })
      end
    end
  end
end
