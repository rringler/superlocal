class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
    	t.integer			:user_id, :null => false
    	t.integer			:post_id, :null => false
    	t.text				:text, 		:null => false

      t.timestamps
    end
  end

  def down
  	drop_table :comments
  end
end
