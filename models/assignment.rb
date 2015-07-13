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
  
  # users - Array of collaborator_ids 
  def add_to_collaborations(users)
    users.each do |collaborator_id|
      DB.execute("INSERT INTO collaborations (assignment_id, collaborator_id) VALUES (#{self.id}, #{collaborator_id});")
    end
  end
  
  # Returns the collaborator ids of anyone who worked on this assignment
  def find_collaborators
    collaborators = DB.execute("SELECT collaborator_id FROM collaborations WHERE assignment_id = #{self.id};")
    collaborator_ids = []
    collaborators.each do |collaborator|
      collaborator_ids << collaborator["collaborator_id"]
    end
    collaborator_ids
  end
  
  def delete_collaborations
    DB.execute("DELETE FROM collaborations WHERE assignment_id = #{self.id};")
  end
end

# SELECT assignments.assignment_name, assignments.description, assignments.link, assignments.repository, collaborators.collaborator_name FROM collaborations INNER JOIN assignments ON assignments.id = collaborations.assignment_id INNER JOIN collaborators ON collaborators.id = collaborations.collaborator_id;