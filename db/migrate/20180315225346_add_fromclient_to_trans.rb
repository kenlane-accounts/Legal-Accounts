class AddFromclientToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :FromClientBank, index: true, foreign_key: true
  end
end
