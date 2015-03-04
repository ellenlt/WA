class User < ActiveRecord::Base
  attr_accessor :password_virtual_attr

	has_many :photos
	has_many :comments
  has_many :tags

	def full_name
  		self.first_name + " " + self.last_name
  end

  # Getter method for the user's typed password
  def password
  		 return password_virtual_attr
  end

  # Takes in the user's typed password
  # Computes the user's salt and password digest and stores in db
  # Saves typed password as a virtual attribute
  def password=(password)
  		self.salt = Random.rand.to_s
  		self.password_digest = Digest::SHA1.hexdigest(password + self.salt)
      
      self.password_virtual_attr = password
  end

  # Returns true if candidate password matches the password for a particular user
  def password_valid?(candidate)
      candidate_digest = Digest::SHA1.hexdigest(candidate + self.salt)
  	  return candidate_digest == self.password_digest
  end

  # Checks that all fields were entered
  validates :first_name, :last_name, :login, :password, :password_confirmation, presence: true

  # Makes sure there is not already a user with the same login
  validates_uniqueness_of :login, :case_sensitive => false, :message => "error: username already taken"

  # Confirms that password and confirmation password match
  validates :password, :confirmation => true

end
