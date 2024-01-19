# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

10.times do
  proponent = Proponent.create!(
    name: FFaker::Name.name,
    cpf: FFaker::IdentificationBR.cpf,
    date_of_birth: FFaker::Time.between(30.years.ago, 18.years.ago),
    salary: rand(0..7786.02).to_f.round(2)
  )

  proponent.contacts.create!(
    contact_type: 'personal',
    phone_number: FFaker::PhoneNumberBR.phone_number
  )

  proponent.contacts.create!(
    contact_type: 'reference',
    phone_number: FFaker::PhoneNumberBR.phone_number
  )

  proponent.create_address!(
    street: FFaker::AddressBR.street_name ,
    number: FFaker::AddressBR.building_number,
    neighborhood: FFaker::AddressBR.neighborhood,
    city: FFaker::AddressBR.city,
    state: FFaker::AddressBR.state_abbr,
    cep: FFaker::AddressBR.zip_code
  )

  UpdateSalaryJob.perform_async(proponent.id)
end
