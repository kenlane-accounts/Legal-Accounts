class RemoveTypeFromNominalss < ActiveRecord::Migration
  def change
    remove_column :nominals, :type, :boolean
  end
end
