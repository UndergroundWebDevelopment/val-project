class Action < ActiveRecord::Base
  class Form < Reform::Form
    model Action

    property :name
    property :description

    property :operation # When created individually, required to associate this action with it's parent operation.

    property :type # Type of action, used to determine how to cary out the action when triggered.

    # Collection of mappings between a "source" field name, which will be
    # supplied by the owning operation, and an "external_api_field" name,
    # which (predicatably) maps to a field on the external_api interface.
    collection :field_mappings do
      property :source_field_name
      property :external_api_field_name

      validates :source_field_name, :external_api_field_name, presence: true
    end

    validates :name, :type, presence: true
  end
end
