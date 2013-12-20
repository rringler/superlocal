class CreateBoards < ActiveRecord::Migration
  def up
    create_table :boards do |t|
      t.string      :title,       :null => false, :limit => 255
      t.string      :slug,        :null => false
      t.text        :description

      t.timestamps
    end
  end

  def down
    drop_table :boards
  end
end
