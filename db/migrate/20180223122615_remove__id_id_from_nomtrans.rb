class RemoveIdIdFromNomtrans < ActiveRecord::Migration
  def change
    remove_column :nomtrans, :supplier_id_id, :integer
  end
end
