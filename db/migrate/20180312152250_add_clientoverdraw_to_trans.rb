class AddClientoverdrawToTrans < ActiveRecord::Migration
  def change
    add_column :trans, :clientoverdraw, :boolean
  end
end
