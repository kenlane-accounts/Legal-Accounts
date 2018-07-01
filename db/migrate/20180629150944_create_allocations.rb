class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.integer :invoice_id
      t.integer :receipt_id
      t.integer :invoice_tran_id
      t.integer :receipt_tran_id

      t.decimal :amount, precision: 15, scale: 2
      t.decimal :vat, precision: 15, scale: 2

      t.timestamps null: false
    end
  end
end
