# frozen_string_literal: true

# TODO: spec
class AmountType < ActiveRecord::Type::Decimal
  def cast(value)
    value = value.gsub(/,/, '.') if value.is_a?(String)

    super(value)
  end
end
