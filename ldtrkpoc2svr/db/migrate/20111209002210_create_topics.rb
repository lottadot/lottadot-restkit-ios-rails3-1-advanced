class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :body
      t.belongs_to :post

      t.timestamps
    end
    add_index :topics, :post_id
  end
end
