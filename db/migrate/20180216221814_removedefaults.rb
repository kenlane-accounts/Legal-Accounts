class Removedefaults < ActiveRecord::Migration
  def change
    change_column_default(:trans, :tramount, nil)
    change_column_default(:trans, :vatamount, nil)
    change_column_default(:trans, :netamount, nil)
  end
end
