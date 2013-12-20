class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      ## Foreign keys
      t.integer     :user_id,  :null => false
      t.integer     :board_id, :null => false

      ## Post attributes
      t.string      :title,    :null => false, :limit => 255
      t.string      :link                    , :limit => 255
      t.text        :text

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, :board_id
  end

  def down
    drop_table :posts
  end
end
