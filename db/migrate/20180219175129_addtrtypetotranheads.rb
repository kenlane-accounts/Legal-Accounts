class Addtrtypetotranheads < ActiveRecord::Migration
  def change
        add_column :tranheads, :trtype, :string
  end
end
