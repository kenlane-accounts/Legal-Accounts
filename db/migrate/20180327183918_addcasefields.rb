class Addcasefields < ActiveRecord::Migration
  def change
    add_reference :tranheads, :case_id, index: true, foreign_key: true
    add_reference :nomtrans, :matter_id, index: true, foreign_key: true
    add_reference :trans, :matter_id, index: true, foreign_key: true
    add_reference :transfers, :frommatter_id, index: true, foreign_key: true
    add_reference :transfers, :tomatter_id, index: true, foreign_key: true
  end
end
