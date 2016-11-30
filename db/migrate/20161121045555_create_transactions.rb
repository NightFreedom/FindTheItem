class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :place_name
      t.datetime :date_time
      t.string :process
      t.string :company

      t.timestamps null: false
    end
  end
end
