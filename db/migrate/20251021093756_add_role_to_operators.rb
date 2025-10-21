class AddRoleToOperators < ActiveRecord::Migration[8.0]
  def change
    add_column :operators, :role, :string
  end
end
