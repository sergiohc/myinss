json.array! @proponents do |proponent|
  json.extract! proponent, :id, :name, :cpf, :date_of_birth, :salary, :inss_discount, :net_salary
  json.address do
    json.extract! proponent.address, :id, :street, :number, :neighborhood, :city, :state, :cep
  end
  json.contacts proponent.contacts do |contact|
    json.extract! contact, :id, :contact_type, :phone_number
  end
end