class AddOutamountToTran < ActiveRecord::Migration
  def change
    add_column :trans, :outamount, :decimal, :precision => 10, :scale => 2
  end
end
