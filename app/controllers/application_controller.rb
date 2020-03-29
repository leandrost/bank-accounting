# frozen_string_literal: true

# Base API controller
class ApplicationController < ActionController::API
  private

  def render_json_errors_for(resource)
    render(
      json: resource,
      status: :unprocessable_entity,
      serializer: ActiveModel::Serializer::ErrorSerializer
    )
  end
end
