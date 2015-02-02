class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.column :user_id, 		:integer
    	t.column :date_time, 	:time
    	t.column :file_name,	:string
        t.timestamps
    end
  end
end
