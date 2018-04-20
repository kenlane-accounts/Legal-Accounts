class FixTypeInTransfer < ActiveRecord::Migration
  def change
    remove_column :transfers, :FromType, :string
    remove_column :transfers, :ToType, :string
    remove_column :transfers, :Trantype, :string

    add_column :transfers, :fromtype, :string
    add_column :transfers, :totype, :string
    add_column :transfers, :trantype, :string
  end
end
