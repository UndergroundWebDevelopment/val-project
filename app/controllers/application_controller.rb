require 'application_responder'
require 'trailblazer/operation/controller/active_record'

class ApplicationController < ActionController::Base
  # Cause trailblazer to create named instance variables, e.g. @song
  include Trailblazer::Operation::Controller
  include Trailblazer::Operation::Controller::ActiveRecord

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
