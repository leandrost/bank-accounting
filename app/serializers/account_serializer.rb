# frozen_string_literal: true

# Serializer to  accounts resource
# TODO: spec
class AccountSerializer < ActiveModel::Serializer
  attributes :name, :balance
end
