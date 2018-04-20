class AddOverdrawToTranhead < ActiveRecord::Migration
  def change
    add_column :tranheads, :overdraw, :boolean
  end
end
