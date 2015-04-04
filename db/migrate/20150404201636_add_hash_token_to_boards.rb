class AddHashTokenToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :hash_token, :string
  end
end
