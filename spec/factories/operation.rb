class OperationFactory
  def self.default(opts = {})
    defaults = {
      name: "Test Operation", 
      event_type: "foobar"
    }
    Operation::Create[operation: defaults.merge(opts)].model
  end
end
