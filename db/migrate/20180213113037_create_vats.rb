class CreateVats < ActiveRecord::Migration
  def change
    create_table :vats do |t|
      t.string :vatcode
      t.decimal :vatperc

      t.timestamps null: false
    end
  end
end
