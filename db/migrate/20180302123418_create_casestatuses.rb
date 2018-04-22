class CreateCasestatuses < ActiveRecord::Migration
  def change
    create_table :casestatuses do |t|
      t.string :code
      t.string :description

      t.timestamps null: false
    end
  end
end
