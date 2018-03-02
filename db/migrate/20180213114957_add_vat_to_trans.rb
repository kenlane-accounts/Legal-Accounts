class AddVatToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :vat, index: true, foreign_key: true
  end
end
