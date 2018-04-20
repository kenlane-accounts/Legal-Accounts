class RemoveOutlayIdFromTrans < ActiveRecord::Migration
  def change
    remove_column :trans, :outlay_id, :integer
  end
end
