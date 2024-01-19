# frozen_string_literal: true

class CreateProponents < ActiveRecord::Migration[7.1]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :cpf
      t.date :date_of_birth
      t.decimal :salary

      t.timestamps
    end
  end
end
