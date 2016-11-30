class AddImagePath < ActiveRecord::Migration
  def change
      add_column :items, :image_path, :string
      add_column :items, :image_name, :string
  end
end
