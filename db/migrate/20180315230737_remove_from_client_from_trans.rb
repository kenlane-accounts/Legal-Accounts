class RemoveFromClientFromTrans < ActiveRecord::Migration
  def change
    remove_reference :trans, :FromClientBank, index: true, foreign_key: true
    add_reference :trans, :fromclientbank, index: true, foreign_key: true
  end
end
