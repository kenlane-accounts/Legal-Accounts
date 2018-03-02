class AddSupcontrolToNomtrans < ActiveRecord::Migration
  def change
    add_reference :nomtrans, :supplier_id, index: true, foreign_key: true
  end
end
