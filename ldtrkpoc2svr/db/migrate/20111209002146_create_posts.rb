class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.belongs_to :user

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
