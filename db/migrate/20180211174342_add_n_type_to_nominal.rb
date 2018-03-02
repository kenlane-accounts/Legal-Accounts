class AddNTypeToNominal < ActiveRecord::Migration
  def change
    add_column :nominals, :ntype, :boolean
  end
end
