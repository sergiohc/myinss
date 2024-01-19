# frozen_string_literal: true

class AddIndexToProponents < ActiveRecord::Migration[7.1]
  def change
    add_index :proponents, :cpf, unique: true
  end
end
