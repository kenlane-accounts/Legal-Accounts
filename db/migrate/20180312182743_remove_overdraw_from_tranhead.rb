class RemoveOverdrawFromTranhead < ActiveRecord::Migration
  def change
    remove_column :tranheads, :overdraw, :boolean
    remove_column :trans, :clientoverdraw, :boolean
  end
end
