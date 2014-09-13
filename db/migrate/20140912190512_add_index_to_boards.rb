class AddIndexToBoards < ActiveRecord::Migration
  def change
  	add_index :boards, [:project_id]
  end
end
