class ConditionsController < ApplicationController
  def new
    form Condition::Create
  end

  def edit
    form Condition::Update
  end

  def show
    present Condition::Update
    respond_with @model
  end

  def create
    respond Condition::Create
  end

  def update
    respond Condition::Update
  end

  def destroy
    respond Condition::Destroy
  end
end
