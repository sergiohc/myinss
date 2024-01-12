class Contact < ApplicationRecord
  belongs_to :proponent

  enum type: { personal: 0, reference: 1 }
end
