class AddElapsedToItems < ActiveRecord::Migration
  def change
    add_column :items, :elapsed, :float
  end
end
