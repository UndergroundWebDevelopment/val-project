require 'rails_helper'
require 'factories/operation'

RSpec.describe Condition::Create do
  let(:operation) { OperationFactory.default(name: "Test Operation") }

  it "persists valid" do
    condition = Condition::Create[condition: {
      operation: operation,
      operator_field_name: "operator_field",
      operator: "==",
      operand_field_name: "operand_field",
      data_type: "String",
    }].model

    expect(condition.persisted?).to be true
    expect(condition.operation).to eq operation
    expect(condition.operator).to eq "=="
    expect(condition.operator_field_name).to eq "operator_field"
    expect(condition.operand_field_name).to eq "operand_field"
    expect(condition.data_type).to eq "String"
  end

  it "invalid" do
    res, op = Condition::Create.run(condition: {operator_field_name: ""})

    expect(res).to eq false
    expect(op.model).to_not be_persisted
    expect(op.contract.errors.details[:operator_field_name]).to eq([{error: "can't be blank"}])
  end
end

RSpec.describe Condition::Update do
  let(:operation) { OperationFactory.default(name: "Test Operation") }

  let(:condition) do
    Condition::Create[condition: {
      operation: operation,
      operator_field_name: "operator_field",
      operator: "==",
      operand_field_name: "operand_field",
      data_type: "String",
    }].model
  end

  it "persists valid" do
    Condition::Update[
      id: condition.id,
      condition: {
        operator_field_name: "operator_field_updated",
      }
    ].model

    condition.reload

    expect(condition.operator_field_name).to eq "operator_field_updated"
    # TODO: Extend this test, test other updateable attributes
  end
end

RSpec.describe Condition::Destroy do
  let(:operation) { OperationFactory.default(name: "Test Operation") }

  let(:condition) do
    Condition::Create[condition: {
      operation: operation,
      operator_field_name: "operator_field",
      operator: "==",
      operand_field_name: "operand_field",
      data_type: "String",
    }].model
  end

  it "destroys valid" do
    Condition::Destroy[
      id: condition.id,
    ]

    expect{condition.reload}.to raise_error ActiveRecord::RecordNotFound
  end
end
