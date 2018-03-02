class AddVatCodeBackToVat < ActiveRecord::Migration
  def change
    add_column :vats, :code, :string
  end
end
