class Addcasesagain < ActiveRecord::Migration
  def change
    add_reference :tranheads, :case, index: true, foreign_key: true
    add_reference :nomtrans, :case, index: true, foreign_key: true
    add_reference :trans, :case, index: true, foreign_key: true
    add_column :transfers, :fromcase_id, :integer, index: true, foreign_key: true
    add_column :transfers, :tocase_id, :integer, index: true, foreign_key: true
  end
end
