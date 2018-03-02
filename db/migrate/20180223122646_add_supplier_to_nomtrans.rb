class AddSupplierToNomtrans < ActiveRecord::Migration
  def change
    add_reference :nomtrans, :supplier, index: true, foreign_key: true
  end
end
