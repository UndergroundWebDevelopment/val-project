class Condition < ActiveRecord::Base
  class Form < Reform::Form
    model Condition

    property :operation # If this condition is being manipulated / created in isolation, instead of as part of an operation, this field is required to set the associated operation!

    property :operator_field_name # The operation is expected to provide an operator field matching this value.
    property :operator
    property :operand_field_name # The operation is expected to provide an operand field matching this value, IF SET (see operand_value)
    property :operand_value # May replace operand_field_name to provide a hard-coded value.
    property :data_type # e.g. Integer, Float, Double, String etc. Both operator and operand will be typecast to this type.

    validates :operator_field_name,
      :operator,
      :data_type,
      presence: true

    validate :operand_present
    
    # Make sure one of the operand_field_name or operand_value is present,
    # else error on both fields.
    def operand_present
      unless operand_field_name.present? || operand_value.present?
        [:operand_field_name, :operand_value].each do |field|
          errors.add(field, "must be set!")
        end
      end
    end
  end
end
