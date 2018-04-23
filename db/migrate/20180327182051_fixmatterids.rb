class Fixmatterids < ActiveRecord::Migration
  def change
    remove_column :tranheads, :matter_id
    remove_column :nomtrans, :matter_id
    remove_column :trans, :matter_id
  end
end
