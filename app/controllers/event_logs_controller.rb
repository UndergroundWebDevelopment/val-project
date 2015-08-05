class EventLogsController < ApplicationController
  def index
    respond_with policy_scope EventLog
  end

  def show
    present EventLog::Update
    respond_with @model
  end

  def create
    run EventLog::Create do |op|
      return head status: :created
    end

    return head status: :unprocessable_entity
  end

  private

  def process_params!(params)
    # Custom param processing for the create method. That method gets the
    # type passed in through the URL, and the channel_id also needs to be set
    # from the session.
    if params[:action] == "create"
      params[:event_log] = {}
      params[:event_log].tap do |e|
        e[:type] = params[:type]
      # Merge channel id into params hash. TODO: handle this better
      # when auth implemented.
        e[:channel_id] = current_channel.id
        e[:payload] = JSON.parse(request.body.string)
      end
    end
    super
  end

  # TODO: Change this once we introduce proper authentication!
  def current_channel
    require 'factories/channel'
    ChannelFactory.default
  end
end
