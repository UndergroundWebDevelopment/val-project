class ActionFactory
  def self.default(opts = {})
    defaults = {
      operation: OperationFactory.default,
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
      type: "Action",
    }
    Action::Create[action: defaults.merge(opts)].model
  end
end
