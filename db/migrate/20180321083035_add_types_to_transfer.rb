class AddTypesToTransfer < ActiveRecord::Migration
  def change
    add_column :transfers, :FromType, :string
    add_column :transfers, :ToType, :string
    add_column :transfers, :Trantype, :string
  end
end
