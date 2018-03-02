class AddVatToNomTrans < ActiveRecord::Migration
  def change
    add_reference :nomtrans, :vat, index: true, foreign_key: true
  end
end
