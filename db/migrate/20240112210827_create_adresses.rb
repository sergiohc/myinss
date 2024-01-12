class CreateAdresses < ActiveRecord::Migration[7.1]
  def change
    create_table :adresses do |t|
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :state
      t.string :cep
      t.references :proponents, null: false, foreign_key: true

      t.timestamps
    end
  end
end
