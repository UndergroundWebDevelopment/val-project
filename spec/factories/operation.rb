class OperationFactory
  def self.default
    Operation::Create[operation: {name: "Test Operation", event_type: "foobar"}].model
  end
end
