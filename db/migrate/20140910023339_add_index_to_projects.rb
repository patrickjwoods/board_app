class AddIndexToProjects < ActiveRecord::Migration
  def change
  	 add_index :projects, :user_id
  end
end
