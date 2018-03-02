class RemoveVatId2fromNomtran < ActiveRecord::Migration
  def change
    remove_column :nomtrans, :vat_id, :integer
  end
end
