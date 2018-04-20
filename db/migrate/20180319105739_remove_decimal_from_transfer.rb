class RemoveDecimalFromTransfer < ActiveRecord::Migration
  def change
    remove_column :transfers, :decimal, :decimal
  end
end
