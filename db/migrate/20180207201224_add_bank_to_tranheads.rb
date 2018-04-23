class AddBankToTranheads < ActiveRecord::Migration
  def change
    add_column :tranheads, :bank_id, :integer, index: true, foreign_key: true
  end
end
