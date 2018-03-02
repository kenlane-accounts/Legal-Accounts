class AddSupplierToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :supplier, index: true, foreign_key: true
  end
end
