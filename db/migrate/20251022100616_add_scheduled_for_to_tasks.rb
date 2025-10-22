class AddScheduledForToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :scheduled_for, :datetime
  end
end
