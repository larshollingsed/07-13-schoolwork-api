require 'bcrypt'
require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class User 
 
  include BCrypt
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :email
  attr_reader :password
  
  def initialize(args={})
    @id = args["id"]
    @email = args["email"]
    @password = args["password"]
  end

  def json_format
    hash = {}
    hash["id"] = self.id
    hash["email"] = self.email
    hash["password"] = self.password
    hash
  end
  
  def self.get_user_for_login(email)
    user = DB.execute("SELECT * FROM users WHERE email = '#{email}';")[0]
    if user
      password = BCrypt::Password.new(user["password"])
      User.new({"id" => user["id"], "password" => password})
    end
  end
  
  def correct_password?(attempted_password)
    self.password == attempted_password
  end

end