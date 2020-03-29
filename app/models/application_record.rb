# frozen_string_literal: true

# Base class to application models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # TODO: spec
  def serializable_hash(options)
    klass = Object.const_get("#{self.class.name}Serializer")
    klass.new(self, options)
  rescue NameError
    raise NotImplementedError
  end
end
