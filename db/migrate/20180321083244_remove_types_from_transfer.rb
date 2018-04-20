class RemoveTypesFromTransfer < ActiveRecord::Migration
  def change
    remove_column :transfers, :FromType, :string
    remove_column :transfers, :ToType, :string
    remove_column :transfers, :Trantype, :string

    add_column :transfers, :FromType, :string
    add_column :transfers, :ToType, :string
    add_column :transfers, :Trantype, :string
  end
end
