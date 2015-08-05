require 'rails_helper'
require 'acceptance_helper'
require 'rspec_api_documentation/dsl'
require 'factories/channel'

resource "EventLogs" do
  let(:channel) { ChannelFactory.default }
  let(:type) { "github_issue_created" }
  let(:payload) { { "extra" => "random" } }

  post "/event_logs/:type" do
    parameter :type, "The type of event being sent."

    let(:raw_post) do
      params.merge(payload).to_json
    end

    example_request "Logging a new event via HTML request." do
      expect(response_status).to eq 201
      last_event = EventLog.last
      expect(last_event.type).to eq type
      expect(last_event.payload).to eq payload
    end
  end

  post "/event_logs.json" do
    let(:channel_id) { channel.id }

    parameter :type, "The type of event being sent."
    parameter :channel_id, "The id of the channel sending this event."
    parameter :payload, "A JSON hash of details about the event."

    example_request "Logging a new event via JSON api." do
      expect(response_status).to eq 201
      last_event = EventLog.last
      expect(last_event.type).to eq type
      expect(last_event.payload).to eq payload
    end

  end
end
