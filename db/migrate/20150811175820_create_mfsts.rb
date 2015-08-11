class CreateMfsts < ActiveRecord::Migration
  def up
    create_table :mfsts do |t|
      t.string :content
      t.integer :user_id
    end
  end
  
  def down
    drop_table :mfsts
  end
  
end
