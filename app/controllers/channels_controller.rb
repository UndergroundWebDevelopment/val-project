class ChannelsController < ApplicationController
  def new
    form Channel::Create
  end

  def edit
    form Channel::Update
  end

  def show
    present Channel::Update
  end

  def create
    respond Channel::Create do |op|
      return respond_with op.contract
    end
  end

  def update
    respond Channel::Update do |op|
      return respond_with op.contract
    end
  end

  def destroy
    respond Channel::Destroy do |op|
      return respond_with op.contract
    end
  end
end
