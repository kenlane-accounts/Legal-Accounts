class AddOutlayToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :outlay, index: true, foreign_key: true
    add_column :trans, :thirdp, :boolean
  end
end
