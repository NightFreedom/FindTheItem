class AddExtraToUsers < ActiveRecord::Migration
  def change
      add_column :users, :location, :string
      add_column :users, :process, :string
      add_column :users, :company, :string
  end
end
