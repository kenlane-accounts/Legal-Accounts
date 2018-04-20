class AddOutbillToTrans < ActiveRecord::Migration
  def change
    add_column :trans, :outlaybill, :string
  end
end
