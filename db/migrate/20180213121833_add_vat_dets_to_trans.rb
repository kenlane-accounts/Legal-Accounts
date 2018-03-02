class AddVatDetsToTrans < ActiveRecord::Migration
  def change
    add_column :trans, :vatperc, :decimal
    add_column :trans, :vatamount, :decimal
  end
end
