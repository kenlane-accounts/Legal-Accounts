class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :type
      t.date :date
      t.string :reference
      t.decimal :amount, :decimal, :precision => 15, :scale => 2 
      t.string :fromdetails
      t.integer :frombank_id, index: true, foreign_key: true
      t.integer :fromnominal_id, index: true, foreign_key: true
      t.string :todetails
      t.integer :tobank_id, index: true, foreign_key: true
      t.integer :tonominal_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
