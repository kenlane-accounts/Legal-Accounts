class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :type
      t.date :date
      t.string :reference
      t.decimal :amount, :decimal, :precision => 15, :scale => 2 
      t.string :fromdetails
      t.references :frombank, index: true, foreign_key: true
      t.references :fromnominal, index: true, foreign_key: true
      t.string :todetails
      t.references :tobank, index: true, foreign_key: true
      t.references :tonominal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
