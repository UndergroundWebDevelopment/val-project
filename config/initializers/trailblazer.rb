require 'trailblazer/autoloading'

# NOTE: Hack from
# https://github.com/apotonick/gemgem-trbrb/blob/88dabcdbe9b75d2408e934093d945ad1732cd2f1/config/initializers/trailblazer.rb#L27
#
# I extend the CRUD module here to make it also include CRUD::ActiveModel globally. This is my choice as the
# application architect. Don't do it if you don't use ActiveModel form builders/models.
Trailblazer::Operation::CRUD.module_eval do
  module Included
    def included(base)
      super # the original CRUD::included method.
      base.send :include, Trailblazer::Operation::CRUD::ActiveModel
    end
  end
  extend Included # override CRUD::included.
end
