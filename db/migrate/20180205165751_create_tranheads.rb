class CreateTranheads < ActiveRecord::Migration
  def change
    create_table :tranheads do |t|
      t.string :trref
      t.date :trdate

      t.timestamps null: false
    end
  end
end
