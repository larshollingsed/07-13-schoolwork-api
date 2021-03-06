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
  
  # Returns an Array of the collaborator ids of anyone who worked on this assignment
  def find_collaborators
    collaborators = DB.execute("SELECT collaborator_id FROM collaborations WHERE assignment_id = #{self.id};")
    collaborator_ids = []
    collaborators.each do |collaborator|
      collaborator_ids << collaborator["collaborator_id"].to_i
    end
    collaborator_ids
  end
  
  def delete_collaborations
    DB.execute("DELETE FROM collaborations WHERE assignment_id = #{self.id};")
  end
  
  def remove_collaborator(collaborator_id)
    DB.execute("DELETE FROM collaborations WHERE assignment_id = #{self.id} AND collaborator_id = #{collaborator_id}")
  end
  
  def json_format
    hash = {}
    hash["id"] = self.id
    hash["assignment_name"] = self.assignment_name
    hash["description"] = self.description
    hash["repository"] = self.repository
    hash["link"] = self.link
    hash
  end
  
  # checks to see if a collaborator is assigned to this assignment already
  # collaborator_id is the id of the collaborator
  # Returns True/False
  def has_collaborator?(collaborator_id)
    if DB.execute("SELECT * FROM collaborations WHERE collaborator_id = #{collaborator_id} and assignment_id = #{self.id};") == []
      false
    else
      true
    end
  end
  
end

# SELECT assignments.assignment_name, assignments.description, assignments.link, assignments.repository, collaborators.collaborator_name FROM collaborations INNER JOIN assignments ON assignments.id = collaborations.assignment_id INNER JOIN collaborators ON collaborators.id = collaborations.collaborator_id;