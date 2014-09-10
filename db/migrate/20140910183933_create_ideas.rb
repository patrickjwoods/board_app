class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :url
      t.integer :board_id

      t.timestamps
    end
  end
end
