class CreateNomtrans < ActiveRecord::Migration
  def change
    create_table :nomtrans do |t|
      t.references :tran, index: true, foreign_key: true
      t.references :nominal, index: true, foreign_key: true
      t.date :date
      t.decimal :amount
      t.string :type

      t.timestamps null: false
    end
  end
end
