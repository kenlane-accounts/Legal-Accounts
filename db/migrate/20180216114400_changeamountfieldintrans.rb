class Changeamountfieldintrans < ActiveRecord::Migration
  def change
    change_column :trans, :tramount, :decimal, :precision => 15, :scale => 2 
    change_column :trans, :vatperc, :decimal, :precision => 15, :scale => 2 
    change_column :trans, :vatamount, :decimal, :precision => 15, :scale => 2 
  end
end
