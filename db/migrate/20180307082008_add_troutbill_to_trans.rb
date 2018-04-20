class AddTroutbillToTrans < ActiveRecord::Migration
  def change
    add_column :trans, :troutlaybill, :string
  end
end
