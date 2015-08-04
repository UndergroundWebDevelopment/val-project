require 'rails_helper'
require 'action/process'
require 'factories/operation'
require 'factories/action'

RSpec.describe Action::Process do
  let(:event_type) { "github_issue_created" }
  let(:operation) { OperationFactory.default(event_type: event_type) }
  let(:action) { ActionFactory.default(operation: operation) }


  it "creates an action_log record and sets it processed" do
    processed_action_log = Action::Process[action, {}].action_log

    expect(processed_action_log.persisted?).to be true
    expect(processed_action_log.last_started_processing_at).to be
    expect(processed_action_log.successfully_processed_at).to be
    expect(processed_action_log.action).to eq action
  end
end
