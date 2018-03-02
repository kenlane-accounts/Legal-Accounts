class RemoveTypeFromTran < ActiveRecord::Migration
  def change
    remove_column :trans, :type, :boolean
  end
end
