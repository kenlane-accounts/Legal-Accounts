class CreateTrans < ActiveRecord::Migration
  def change
    create_table :trans do |t|
      t.string :trdetails
      t.decimal :tramount
      t.references :tranhead, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
