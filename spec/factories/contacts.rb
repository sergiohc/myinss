# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    contact_type { Contact.contact_types.keys.sample }
    phone_number { FFaker::PhoneNumberBR.phone_number }
  end

  factory :personal_contact, class: Contact do
    phone_number { FFaker::PhoneNumberBR.phone_number }
    contact_type { 'personal' }
  end

  factory :reference_contact, class: Contact do
    phone_number { FFaker::PhoneNumberBR.phone_number }
    contact_type { 'reference' }
  end
end
