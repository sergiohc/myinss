# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :proponent, inverse_of: :address
end
