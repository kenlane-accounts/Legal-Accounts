class Changemattertocase < ActiveRecord::Migration
  def change
    rename_table :matters, :cases
  end 
end
