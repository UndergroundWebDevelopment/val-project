class OperationsController < ApplicationController
  def new
    form Operation::Create
    @form.prepopulate!
  end

  def edit
    form Operation::Update
  end

  def show
    present Operation::Update
    respond_with @model
  end

  def create
    respond Operation::Create
  end

  def update
    respond Operation::Update
  end

  def destroy
    respond Operation::Destroy
  end
end
