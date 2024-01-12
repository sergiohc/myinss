class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.integer :type
      t.string :phone_number
      t.references :proponents, null: false, foreign_key: true

      t.timestamps
    end
  end
end
