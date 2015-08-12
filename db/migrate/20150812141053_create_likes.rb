class CreateLikes < ActiveRecord::Migration
  def up
    create_table :likes do |t|
      t.integer :user_id
      t.integer :mfst_id
    end
  end
  
  def down
    drop_table :likes
  end
end
