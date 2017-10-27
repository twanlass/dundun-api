class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :list
    add_reference :lists, :user
  end
end
