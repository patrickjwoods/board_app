class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :boards, :projects_id, :project_id
  end
end
