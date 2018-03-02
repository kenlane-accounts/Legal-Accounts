class AddBankToTranheads < ActiveRecord::Migration
  def change
    add_reference :tranheads, :bank, index: true, foreign_key: true
  end
end
