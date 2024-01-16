class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :address, :contacts

  validates :cpf, uniqueness: true
end
