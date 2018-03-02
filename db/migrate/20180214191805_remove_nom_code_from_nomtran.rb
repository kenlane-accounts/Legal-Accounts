class RemoveNomCodeFromNomtran < ActiveRecord::Migration
  def change
    remove_column :nomtrans, :nomcode, :string
  end
end
