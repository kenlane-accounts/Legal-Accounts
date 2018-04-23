class AddOutlayToTrans < ActiveRecord::Migration
  def change
    add_column :trans, :thirdp, :boolean
  end
end
