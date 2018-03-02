class AddBankToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :bank, index: true, foreign_key: true
  end
end
