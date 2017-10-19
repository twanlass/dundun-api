class RenameItemColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :isEvent, :is_event
    rename_column :items, :completedAt, :completed_at
    rename_column :items, :dueAt, :due_at
  end
end
