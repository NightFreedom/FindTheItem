class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.datetime :date_time
      t.string :owner
      t.string :description
      t.string :transactions

      t.timestamps null: false
    end
  end
end
