class AddMattersToTransfer < ActiveRecord::Migration
  def change
    add_reference :transfers, :frommatter, index: true, foreign_key: true
    add_reference :transfers, :tomatter, index: true, foreign_key: true
  end
end
