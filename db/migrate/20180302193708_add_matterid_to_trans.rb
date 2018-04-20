class AddCaseidToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :matter, index: true, foreign_key: true
  end
end
