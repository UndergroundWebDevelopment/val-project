class EventLogsController < ApplicationController
  def index
    respond_with policy_scope EventLog
  end

  def show
    present EventLog::Update
    respond_with @model
  end

  def create
    respond EventLog::Create
  end
end
