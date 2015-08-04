class Condition < ActiveRecord::Base
  belongs_to :operation

  def matches?(data_set)
    type_class = data_type.constantize

    operator_val = send(type_class, data_set[operator_field_name])
    if operand_field_name.present?
      operand_val = data_set[operand_field_name]
    else
      operand_val = operand_value
    end
    operand_val = send(type_class, operand_val)

    operator_val.send(operator, operand_val)
  end
end
