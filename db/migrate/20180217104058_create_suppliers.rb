class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :supcode
      t.string :supname

      t.timestamps null: false
    end
  end
end
