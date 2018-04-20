class AddPinvfieldsToTranhead < ActiveRecord::Migration
  def change
    add_column :tranheads, :trotherref, :string
    add_reference :tranheads, :supplier, index: true, foreign_key: true
  end
end
