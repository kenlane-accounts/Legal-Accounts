class AddTranidToTranhead < ActiveRecord::Migration
  def change
    add_reference :tranheads, :transfer, index: true, foreign_key: true
  end
end
