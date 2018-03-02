class RemovenTypeFromNominal2 < ActiveRecord::Migration
  def change
    remove_column :nominals, :ntype, :boolean
  end
end
