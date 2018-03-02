class AddTTypeToNomtran < ActiveRecord::Migration
  def change
    add_column :nomtrans, :ttype, :string
  end
end
