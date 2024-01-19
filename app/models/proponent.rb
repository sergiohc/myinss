# frozen_string_literal: true

class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy, inverse_of: :proponent
  has_many :contacts, dependent: :destroy, inverse_of: :proponent

  accepts_nested_attributes_for :address, reject_if: :all_blank
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  validates :cpf, uniqueness: true, length: { is: 11 }
  validates :name, presence: true
  validates :salary, numericality: { greater_than: 0, less_than_or_equal_to: 7786.02 }
  validates_associated :address, :contacts
end
