class RemoveVatCodeFromVat < ActiveRecord::Migration
  def change
    remove_column :vats, :vatcode, :string
  end
end
