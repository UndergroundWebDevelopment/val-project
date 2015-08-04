class ChannelFactory
  def self.default
    Channel::Create[channel: {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
    }].model
  end
end
