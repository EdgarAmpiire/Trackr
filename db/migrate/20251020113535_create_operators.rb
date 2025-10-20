class CreateOperators < ActiveRecord::Migration[8.0]
  def change
    create_table :operators do |t|
      t.string :name
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
