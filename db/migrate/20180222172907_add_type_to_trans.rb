class AddTypeToTrans < ActiveRecord::Migration
  def change
    add_column :trans, :type, :string
  end
end
