class Operation < ActiveRecord::Base
  class Form < Reform::Form
    model Operation

    property :name
    property :description

    collection :conditions, form: Condition::Form, 
      prepopulator: ->(*) { self.conditions = [Condition.new] },
      populate_if_empty: ->(*) { Condition.new },
      skip_if: :all_blank

    collection :actions, form: Action::Form, 
      prepopulator: ->(*) { self.actions = [Action.new] },
      populate_if_empty: ->(*) { Action.new },
      skip_if: :all_blank

    validates :name, presence: true
  end
end
