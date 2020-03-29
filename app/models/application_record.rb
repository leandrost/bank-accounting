# frozen_string_literal: true

# Base class to application models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
