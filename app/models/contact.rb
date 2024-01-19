# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :proponent, inverse_of: :contacts

  enum contact_type: { personal: 0, reference: 1 }
end
