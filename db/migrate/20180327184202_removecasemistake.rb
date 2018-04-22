class Removecasemistake < ActiveRecord::Migration
  def change
    remove_column :tranheads, :matter_id_id
    remove_column :nomtrans, :matter_id_id
    remove_column :trans, :matter_id_id
    remove_column :transfers, :frommatter_id_id
    remove_column :transfers, :tomatter_id_id
  end
end
