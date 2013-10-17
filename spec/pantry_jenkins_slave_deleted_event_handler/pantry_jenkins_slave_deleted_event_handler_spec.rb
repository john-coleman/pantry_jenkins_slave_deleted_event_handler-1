require 'spec_helper'
require_relative '../../pantry_jenkins_slave_deleted_event_handler/pantry_jenkins_slave_deleted_event_handler'

describe Wonga::Daemon::PantryJenkinsSlaveDeletedEventHandler do
  let(:message) { {"node" => "jenkins-linux-agent.vagrant", "server_ip" => "127.0.0.1", "server_port" => "8080", 'id' => "443444"} }
  let(:api_client) { instance_double('Wonga::Daemon::PantryApiClient').as_null_object }
  let(:logger) { instance_double('Logger').as_null_object }
  subject { described_class.new(api_client, logger) }

  it_behaves_like 'handler'
  describe "#handle_message" do
    it "sends put request" do
      subject.handle_message(message)
      expect(api_client).to have_received(:send_put_request).with("/api/jenkins_slaves/#{message['id']}", {:removed => true})
    end
  end
end
