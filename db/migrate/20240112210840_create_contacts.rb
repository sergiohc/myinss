# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.integer :contact_type
      t.string :phone_number
      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
