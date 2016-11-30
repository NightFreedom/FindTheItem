class AddDurationToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :duration, :integer
  end
end
