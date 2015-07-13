require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Assignment
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :id, :assignment_name, :description, :repository, :link

  def initialize(args={})
    @id = args["id"]
    @assignment_name = args["assignment_name"]
    @description = args["description"]
    @repository = args["repository"]
    @link = args["link"]
  end
  
  
end