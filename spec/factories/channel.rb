class ChannelFactory
  def self.default(opts = {}, user = nil)
    defaults = {
      name: "Github",
      description: "Workflows to sync github issues and milestones with other apps.",
      type: "github",
    }
    Channel::Create[channel: defaults.merge(opts), current_user: user].model
  end
end
