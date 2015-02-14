class AddPasswordDigestAndSaltToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :string
  	add_column :users, :salt, :string

  	User.reset_column_information

  	#Initializes each user's salt to a random number and password to their login
  	User.all.each do |user|
  		user.password = user.login
  		user.save(:validate => false)
  	end
  end
end
