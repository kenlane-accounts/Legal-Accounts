class CreateClientstatuses < ActiveRecord::Migration
  def change
    create_table :clientstatuses do |t|
      t.string :code
      t.string :description

      t.timestamps null: false
    end
  end
end
