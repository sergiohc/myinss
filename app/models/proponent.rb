class Proponent < ApplicationRecord
  has_one :adress, dependent: :destroy
  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :adress, :contacts

  validates :cpf, uniqueness: true
end
