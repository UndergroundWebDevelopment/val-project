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
end
