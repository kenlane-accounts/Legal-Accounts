class AddOutlayTypeToTrans < ActiveRecord::Migration
  def change
    add_reference :trans, :outlaytype, index: true, foreign_key: true
  end
end
