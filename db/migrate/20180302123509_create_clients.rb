class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.references :clientstatus, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
