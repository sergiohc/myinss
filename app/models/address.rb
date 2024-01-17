class Address < ApplicationRecord
  belongs_to :proponent, inverse_of: :address
end
