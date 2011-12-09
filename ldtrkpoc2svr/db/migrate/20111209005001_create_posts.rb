class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.belongs_to :topic
      t.belongs_to :author

      t.timestamps
    end
    add_index :posts, :topic_id
    add_index :posts, :author_id
  end
end
