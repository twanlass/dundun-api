class ItemsModel < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.boolean :completed, default: false
      t.boolean :isEvent, default: false
      t.datetime :completedAt
      t.datetime :dueAt
      t.timestamps
    end
  end
end
