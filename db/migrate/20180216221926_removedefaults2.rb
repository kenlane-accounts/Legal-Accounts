class Removedefaults2 < ActiveRecord::Migration
  def change
    change_column_default(:trans, :vatperc, nil)
  end
end
