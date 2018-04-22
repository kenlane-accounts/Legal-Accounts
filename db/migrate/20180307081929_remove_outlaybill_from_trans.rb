class RemoveOutlaybillFromTrans < ActiveRecord::Migration
  def change
    remove_column :trans, :outlaybill, :boolean
  end
end
