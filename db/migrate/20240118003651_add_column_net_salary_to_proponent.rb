class AddColumnNetSalaryToProponent < ActiveRecord::Migration[7.1]
  def change
    add_column  :proponents, :net_salary, :decimal
  end
end
