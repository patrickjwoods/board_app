class AddImageRemoteUrlToIdeas < ActiveRecord::Migration
  def self.up
    add_column :ideas, :image_remote_url, :string
  end

  def self.down
    remove_column :ideas, :image_remote_url
  end
end