set :sessions => true

# see all assignments
# returns all of the assignments(including their attributes) in JSON format
get "/api/assignments" do
  assignments = Assignment.all
  json_array = []
  assignments.each do |assignment|
    json_array << assignment.json_format
  end
  json json_array
end

# see all collaborators who worked on an assignment
# :id is the assignments's id
# returns all assignments(including their attributes) that the collaborator worked on in JSON format
get "/api/assignments/:id" do
  assignment = Assignment.find(params["id"])
  collaborator_array = assignment.find_collaborators
  json_array = assignment.json_format
  collaborator_names = []
  collaborator_array.each do |collaborator_id|
    collaborator_names << Collaborator.find(collaborator_id).collaborator_name
  end
  json_array["collaborators"] = assignment.find_collaborators
  json json_array  
end

# see all collaborators
# returns all collaborators(and their attributes) in JSON format
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

# adds a new assignment
# :name is the name of the assignment
# append ?github= followed by the url of the github repository
get "/api/assignments/new/:name" do
  assignment = Assignment.add({"assignment_name" => params["name"], "repository" => params["github"]})
  json_array = []
  json_array << assignment.json_format
  json json_array
end

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

post "/api/modify_assignment_confirm" do 
  modified_assignment = Assignment.new({"id" => params["assignment"]["id"], "assignment_name" => params["assignment"]["name"], "link" => params["assignment"]["link"], "repository" => params["assignment"]["repository"], "description" => params["assignment"]["description"]})
  modified_assignment.save
  modified_assignment.delete_collaborations
  modified_assignment.add_to_collaborations(params["assignment"]["collaborator_id"])
  json modified_assignment.json_format
end

get "/api/see_users" do
  users = User.all
  user_array = []
  users.each do |user|
    user_array << user.json_format
  end
  json user_array
end

post "/api/add_user" do
  new_user = User.add({"email" => params["new_user"]["email"], "password" => params["new_user"]["password"]})
  json new_user.json_format
end

post "/api/login" do
  users = User.all
  login_id = false
  users.each do |user|
    if user.email == params["user"]["email"] && user.password == params["user"]["password"]
      login_id = user.id
    end
  end
  if login_id != false
    session["user_id"] = login_id
    json User.find(login_id).json_format
  end
end

get "/api/views/add_user_form" do
  erb :"/api/add_user_form"
end

get "/api/views/login" do
  erb :"/api/login"
end

get "/api/views/modify_assignment" do
  erb :"/api/modify_assignment"
end

get "/api/views/see_collaborators" do
  erb :"/api/see_collaborations"
end