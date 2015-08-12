class SetDefaultNumLikes < ActiveRecord::Migration
  def up
    remove_column :mfsts, :num_likes
    add_column :mfsts, :num_likes, :integer, default: 0
  end
  
  def down
    remove_column :mfsts, :num_likes
    add_column :mfsts, :num_likes, :integer
  end
end
