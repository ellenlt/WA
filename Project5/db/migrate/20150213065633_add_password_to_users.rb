class AddPasswordToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :string
  	add_column :users, :salt, :string

  	User.reset_column_information

  	#Initializes each user's salt to a random number and password to their login
  	User.all.each do |user|
  		user.salt = Random.rand.to_s
  		user.password_digest = Digest::SHA1.hexdigest(user.login + user.salt)
  		user.save
  	end

  end
end
