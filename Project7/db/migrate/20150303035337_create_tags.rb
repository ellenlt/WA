class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
    	t.column :photo_id, :integer
    	t.column :user_id, :integer
    	t.column :x_pos, :integer
    	t.column :y_pos, :integer
    	t.column :width, :integer
    	t.column :height, :integer
    end
  end
end
