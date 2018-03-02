class RemovenominalIdFromTranheads < ActiveRecord::Migration
  def change
    remove_column :tranheads, :nominal_id, :integer
  end
end
