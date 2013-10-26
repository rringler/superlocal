class AddAncestryToComments < ActiveRecord::Migration
  def up
  	add_column :comments, :ancestry, :string
  	add_index  :comments, :ancestry
  end

  def down
  	remove_index  :comments, :ancestry
  	remove_column :comments, :ancestry
  end
end
