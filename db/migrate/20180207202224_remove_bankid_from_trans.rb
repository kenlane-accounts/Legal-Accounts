class RemoveBankidFromTrans < ActiveRecord::Migration
  def change
    remove_column :trans, :bank_id, :integer
  end
end
