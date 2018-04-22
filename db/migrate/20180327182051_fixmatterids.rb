class Fixmatterids < ActiveRecord::Migration
  def change
    remove_column :tranheads, :matter_id
    remove_column :nomtrans, :matter_id
    remove_column :trans, :matter_id
    remove_column :transfers, :frommatter_id
    remove_column :transfers, :tomatter_id
  end
end
