class CreateCases < ActiveRecord::Migration
  def change
    create_table :matters do |t|
      t.string :reference
      t.string :description
      t.references :client, index: true, foreign_key: true
      t.references :casestatus, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
