class AddTypeToTranheads < ActiveRecord::Migration
  def change
    add_column :tranheads, :type, :string
  end
end
