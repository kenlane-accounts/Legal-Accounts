class AddCompanyId < ActiveRecord::Migration
  def change
    add_column :cases, :company_id, :integer
    add_index :cases, :company_id

    add_column :clients, :company_id, :integer
    add_index :clients, :company_id

    add_column :nominals, :company_id, :integer
    add_index :nominals, :company_id

    add_column :nomtrans, :company_id, :integer
    add_index :nomtrans, :company_id

    add_column :suppliers, :company_id, :integer
    add_index :suppliers, :company_id

    add_column :tranheads, :company_id, :integer
    add_index :tranheads, :company_id

    add_column :trans, :company_id, :integer
    add_index :trans, :company_id


    add_column :transfers, :company_id, :integer
    add_index :transfers, :company_id
  end
end
