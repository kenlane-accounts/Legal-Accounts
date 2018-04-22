class AddMatteridToTranhead < ActiveRecord::Migration
  def change
    add_reference :tranheads, :matter, index: true, foreign_key: true
  end
end
