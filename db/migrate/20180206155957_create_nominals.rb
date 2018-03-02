class CreateNominals < ActiveRecord::Migration
  def change
    create_table :nominals do |t|
      t.string :code
      t.string :desc
      t.boolean :isoffice
      t.boolean :isclient
      t.boolean :isdeposit

      t.timestamps null: false
    end
  end
end
