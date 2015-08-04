class EventLogFactory
  def self.default(args = {})
    args[:channel_id] ||= args[:channel].id if args.key?(:channel)
    default = {
      type: "github_issue_created",
      payload: {"foo" => "bar"},
    }

    final = default.merge(args)
    EventLog::Create[event_log: final].model
  end
end
