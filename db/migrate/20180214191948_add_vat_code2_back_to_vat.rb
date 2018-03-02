class AddVatCode2BackToVat < ActiveRecord::Migration
  def change
    add_column :vats, :vatcode, :string
  end
end
