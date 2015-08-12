class ModifyLikesUsersMfsts < ActiveRecord::Migration
  def up
    add_column :mfsts, :num_likes, :integer
  end
  
  def down
    remove_column :mfsts, :num_likes
  end
end
