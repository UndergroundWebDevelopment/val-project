class Condition < ActiveRecord::Base
  class Matcher < Trailblazer::Operation
    def process(condition, data_set)
      type_class = condition.data_type.constantize

      operator_val = condition.send(type_class, condition.data_set[condition.operator_field_name])
      if condition.operand_field_name.present?
        operand_val = condition.data_set[condition.operand_field_name]
      else
        operand_val = condition.operand_value
      end
      operand_val = send(type_class, condition.operand_val)

      result = operator_val.send(condition.operator, operand_val)

      raise "Match failed!" unless result
    end
  end
end
