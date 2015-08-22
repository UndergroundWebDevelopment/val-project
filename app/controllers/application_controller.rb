require 'application_responder'
require 'trailblazer/operation/controller/active_record'
require 'tnt'

# Define some custom error constants that we can throw throughout the code.
NotFound = Tnt.boom AbstractController::ActionNotFound

class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller

  operation document_formats: :json

  # Sets current_user in the params hash, which will be passed into
  # trailblazer for authorization
  before_action :set_current_user

  self.responder = ApplicationResponder
  respond_to :html, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Provides a helper giving access to a Tyrant::Session object, which manages
  # authentication.
  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant

  private

  def set_current_user
    if tyrant.signed_in?
      params[:current_user] = tyrant.current_user
    end
  end
end
