# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :proponent, inverse_of: :address

  def full_address
    [street, number, neighborhood, city, state, cep].compact.join(', ')
  end
end
