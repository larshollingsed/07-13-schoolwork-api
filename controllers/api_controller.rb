# see all assignments
get "/api/assignments" do
  assignments = Assignment.all
  json_array = []
  assignments.each do |assignment|
    json_array << assignment.json_format
  end
  json json_array
end

# see all assignments a collaborator worked on
# :id is the collaborator's id
get "/api/assignments/:id" do
  assignment = Assignment.find(params["id"])
  collaborator_array = assignment.find_collaborators
  json_array = assignment.json_format
  collaborator_names = []
  collaborator_array.each do |collaborator_id|
    collaborator_names << Collaborator.find(collaborator_id).collaborator_name
  end
  json_array["collaborators"] = collaborator_names
  json json_array  
end

# see all collaborators
get "/api/collaborators" do
  collaborators = Collaborator.all
  json_array = []
  collaborators.each do |collaborator|
    json_array << collaborator.json_format
  end
  json json_array
end

# get all assignments a collaborator has worked on
# :id is the collaborator's id
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
# :id is the assignment's id
get "/api/assignments/delete/:id" do
  assignment = Assignment.find(params["id"].to_i)
  assignment.delete
  assignment.delete_collaborations
  json assignment.json_format
end

# add a collaborator
# :name is the collaborator's name
get "/api/collaborators/add/:name" do
  collaborator = Collaborator.add({"collaborator_name" => params["name"]})
  json collaborator.json_format
end

# delete a collaborator
# :id is the collaborator's id
get "/api/collaborators/delete/:id" do
  collaborator = Collaborator.find(params["id"].to_i)
  collaborator.delete
  json collaborator.json_format
end

# add collaborator to existing assignment
# :assignment_id is the assignment's id
# :collaborator_id is the collaborator's id
get "/api/assignments/add_collaborator/:assignment_id/:collaborator_id" do
  assignment = Assignment.find(params["assignment_id"].to_i)
  if !assignment.has_collaborator?(params["collaborator_id"].to_i)
    assignment.add_to_collaborations([params["collaborator_id"].to_i])
    json assignment.json_format
  else
    return "#{Collaborator.find(params['collaborator_id']).collaborator_name} has already been added as a collaborator on #{assignment.assignment_name}."
  end
end