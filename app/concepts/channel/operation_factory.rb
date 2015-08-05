require 'tnt'

class Channel < ActiveRecord::Base
  OperationNotFound = Tnt.boom "Operation not found!"

  # This class handles finding and returning an appropriate operation class
  # for the given service/operation combination. This serves to remove more
  # complex logic from the controller (and though it's simple now, it
  # _will_ become more complex) and also to makes it easier to add that
  # complexity, when the time comes.
  class OperationFactory
    def self.find(service, operation)
      operation_klass = "Channel::#{service.to_s.camelize}::#{operation.to_s.camelize}".safe_constantize

      raise OperationNotFound unless operation_klass.present?

      operation_klass
    end
  end
end
