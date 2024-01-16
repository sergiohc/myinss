class Contact < ApplicationRecord
  belongs_to :proponent

  enum contact_type: { personal: 0, reference: 1 }
end
