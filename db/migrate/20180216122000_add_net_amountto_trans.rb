class AddNetAmounttoTrans < ActiveRecord::Migration
  def change
        add_column :trans, :netamount, :decimal, :precision => 15, :scale => 2 
  end
end
