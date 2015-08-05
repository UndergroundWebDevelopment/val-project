class ChannelsController < ApplicationController
  def new
    form Channel::Create
  end

  def edit
    form Channel::Update
  end

  def show
    present Channel::Update
    respond_with @model
  end

  def create
    respond Channel::Create
  end

  def update
    respond Channel::Update
  end

  def destroy
    respond Channel::Destroy
  end

  # Endpoint for receiving callbacks from external API's as part of OAuth
  # handshake. Will be passed a value in params[:service] referencing the
  # service that sent the callback, taken from a URI segment.
  # e.g. channels/connect/callback/github, params[:service] == 'github'
  def connection_callback
    # Retrieve operation class to use to 'connect' to the given service:
    operation_klass = Channel::OperationFactory.find(params[:service], :connect)
    # Run operation class. If successful, redirect to the operation's model (in
    # this case a channel, that we've just connected to).
    run operation_klass do |op|
      return redirect_to op.model
    end
    # If the operation fails, error out with a head response.
    # TODO: Handle this better, likely by redirecting to the index and setting
    # a flash message indicating an error. JSON access to this endpoint
    # probably won't be a concern.
    head status: :unprocessable_entity
  rescue Channel::OperationNotFound
    # Raise controller level exception, for proper handling. The factory
    # might throw this exception if the service param is invalid. Since
    # that is part of the URL, a NotFound response is returned.
    raise NotFound "Invalid webhook URI"
  end

  def authorize_connection
    github = Github.new client_id: ENV.fetch("GITHUB_CLIENT_ID"), client_secret: ENV.fetch("GITHUB_CLIENT_SECRET")

    redirect_to github.authorize_url
  end
end
