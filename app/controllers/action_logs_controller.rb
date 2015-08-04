class ActionLogsController < ApplicationController
  def index
    respond_with policy_scope ActionLog
  end

  def show
    present ActionLog::Update
    respond_with @model
  end
end
