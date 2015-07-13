require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Collaborator
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :id, :collaborator_name
  
  def initialize(args={})
    @id = args["id"]
    @collaborator_name = args["collaborator_name"]
  end
  
end