class AddListModel < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
