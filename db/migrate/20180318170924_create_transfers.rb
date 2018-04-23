class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.string :type
      t.date :date
      t.string :reference
      t.decimal :amount, :decimal, :precision => 15, :scale => 2 
      t.string :fromdetails
      t.string :todetails

      t.timestamps null: false
    end
  end
end
