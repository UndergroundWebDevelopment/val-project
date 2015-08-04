class ActionsController < ApplicationController
  def new
    form Action::Create
  end

  def edit
    form Action::Update
  end

  def show
    present Action::Update
    respond_with @model
  end

  def create
    respond Action::Create
  end

  def update
    respond Action::Update
  end

  def destroy
    respond Action::Destroy
  end
end
