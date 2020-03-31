# frozen_string_literal: true

class ApplicationService
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :result

  def self.run!(args)
    operation = new(args)
    operation.tap(&:run)
  end

  def run
    self.result = execute
  end

  def success?
    result.errors.blank?
  end

  def failure?
    !success?
  end
end
