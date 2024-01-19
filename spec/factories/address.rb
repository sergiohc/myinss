# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { FFaker::AddressBR.street_name }
    number { FFaker::AddressBR.building_number }
    neighborhood { FFaker::AddressBR.neighborhood }
    city { FFaker::AddressBR.city }
    state { FFaker::AddressBR.state_abbr }
    cep { FFaker::AddressBR.zip_code }
  end
end
