class Addfieldstonomtrans < ActiveRecord::Migration
  def change
    add_reference :nomtrans, :matter, index: true, foreign_key: true
    add_reference :nomtrans, :tranhead, index: true, foreign_key: true
  end
end
