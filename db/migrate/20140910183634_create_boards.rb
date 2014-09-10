class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title
      t.text :description
      t.integer :projects_id

      t.timestamps
    end
  end
end
