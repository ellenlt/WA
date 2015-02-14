class AddLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string

    User.reset_column_information

      #Sets each user's login to their last name, in lowercase
	  User.all.each do |user|
	  	user.login = user.last_name.downcase
	  	user.save(:validate => false)
	  end
	  
  end
end
