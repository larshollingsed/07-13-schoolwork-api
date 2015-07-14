# Larz's Schoolwork Assignment API

## Basic API Documentation


### see all assignments
####/api/assignments
##### returns all of the assignments(including their attributes) in JSON format

### see all assignments a collaborator worked on
####/api/assignments/:id
##### :id is the collaborator's id
##### returns all assignments(including their attributes) that the collaborator worked on in JSON format


#### see all collaborators
#### returns all collaborators(and their attributes) in JSON format
#####/api/collaborators

# get all assignments a collaborator has worked on
# :id is the collaborator's id
# returns all of the assignments(and their attributes) the given collaborator has worked on in JSON format
get "/api/collaborators/:id" do
  collaborator = Collaborator.find(params["id"])
  assignment_ids = collaborator.get_assignments
  json_array = []
  assignment_ids.each do |assignment_id|
    assignment = Assignment.find(assignment_id)
    json_array << assignment.json_format
  end
  json json_array
end

# not working
# get "/api/assignments/new/:name/:github" do
#   assignment = Assignment.add({"assignment_name" => params["name"], "repository" => params["github"]})
#   json_array = []
#   json_array << assignment.json_format
#   json json_array
# end

# delete an assignment
# :id is the assignment's id - INTEGER
# deletes an assignment from the assignments table and all rows from the collaborations tables associated with that assignment
# returns the assignment that was deleted in JSON format
get "/api/assignments/delete/:id" do
  assignment = Assignment.find(params["id"].to_i)
  assignment.delete
  assignment.delete_collaborations
  json assignment.json_format
end

# add a collaborator
# :name is the collaborator's name
# returns the new collaborator in JSON format
get "/api/collaborators/add/:name" do
  collaborator = Collaborator.add({"collaborator_name" => params["name"]})
  json collaborator.json_format
end

# delete a collaborator
# :id is the collaborator's id - INTEGER
# returns the deleted collaborator in JSON format
get "/api/collaborators/delete/:id" do
  collaborator = Collaborator.find(params["id"].to_i)
  collaborator.delete
  json collaborator.json_format
end

# add collaborator to existing assignment
# :assignment_id is the assignment's id - INTEGER
# :collaborator_id is the collaborator's id - INTEGER
# Returns the assignment(JSON format) if successful or a message if unsuccessful
get "/api/assignments/add_collaborator/:assignment_id/:collaborator_id" do
  assignment = Assignment.find(params["assignment_id"].to_i)
  if !assignment.has_collaborator?(params["collaborator_id"].to_i)
    assignment.add_to_collaborations([params["collaborator_id"].to_i])
    json assignment.json_format
  else
    return "#{Collaborator.find(params['collaborator_id']).collaborator_name} has already been added as a collaborator on #{assignment.assignment_name}."
  end
end

# remove a collaborator from an existing assignment
# :assignment_id is the assignment's id - INTEGER
# :collaborator_id is the collaborator's id - INTEGER
# Returns the assignment(JSON format) if successful or a message if unsuccessful
get "/api/assignments/remove_collaborator/:assignment_id/:collaborator_id" do
  assignment = Assignment.find(params["assignment_id"].to_i)
  if assignment.has_collaborator?(params["collaborator_id"].to_i)
    assignment.remove_collaborator(params["collaborator_id"].to_i)
    json assignment.json_format
  else
    return "#{Collaborator.find(params['collaborator_id']).collaborator_name} has not been added as a collaborator on #{assignment.assignment_name}."
  end
end