class AddNominalToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :nominal, index: true, foreign_key: true
  end
end
