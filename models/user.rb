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
    @password = BCrypt::Password.create(args["password"])
  end

end