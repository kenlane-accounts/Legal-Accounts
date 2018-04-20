class AddTypesToTranhead < ActiveRecord::Migration
  def change
    add_column :tranheads, :troffcli, :string
    add_column :tranheads, :trpayrec, :string
    add_column :tranheads, :trtrantype, :string
    
    add_index :tranheads, :troffcli
    add_index :tranheads, :trpayrec
    add_index :tranheads, :trtrantype

  end
end
