class Operation < ActiveRecord::Base
  class Form < Reform::Form
    model Operation

    property :name
    property :description
    property :event_type

    collection :conditions, form: Condition::Form, 
      prepopulator: ->(*) { self.conditions = [Condition.new] },
      populate_if_empty: ->(*) { Condition.new },
      skip_if: :all_blank

    collection :actions, form: Action::Form, 
      prepopulator: ->(*) { self.actions = [Action.new] },
      populate_if_empty: ->(*) { Action.new },
      skip_if: :all_blank

    validates :name, :event_type, presence: true
  end
end
