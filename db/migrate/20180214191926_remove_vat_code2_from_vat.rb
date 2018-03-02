class RemoveVatCode2FromVat < ActiveRecord::Migration
  def change
    remove_column :vats, :code, :string
  end
end
