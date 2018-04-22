class CreateOutlaytypes < ActiveRecord::Migration
  def change
    create_table :outlaytypes do |t|
      t.string :outcode
      t.string :outdesc

      t.timestamps null: false
    end
  end
end
