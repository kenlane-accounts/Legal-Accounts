class RemoveTrtypeFromTrans < ActiveRecord::Migration
  def change
    remove_column :tranheads, :trtype, :string
  end
end
