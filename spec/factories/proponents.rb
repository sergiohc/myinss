# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name { FFaker::Name.name }
    cpf { FFaker::IdentificationBR.cpf }
    date_of_birth { FFaker::Date.birthday(min_age: 18, max_age: 65) }
    salary { rand(0..7786.02).to_f.round(2) }
    inss_discount { 0 }
    net_salary { 0 }

    after(:create) do |proponent|
      create(:address, proponent:)
      create(:personal_contact, proponent:)
    end

    after(:build) do |proponent|
      proponent.address ||= build(:address, proponent:)
      proponent.contacts << build(:contact, contact_type: 'personal', proponent:) if proponent.contacts.empty?
    end
  end
end
