class RemoveFromClientFromTrans < ActiveRecord::Migration
  def change
    add_column :trans, :fromclientbank_id, :integer, index: true, foreign_key: true
  end
end
