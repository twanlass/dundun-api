class AddListTypeAttribute < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :type, :string, default: 'custom'
  end
end
