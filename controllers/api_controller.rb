get "/api/assignments" do
  assignments = Assignment.all
  json_array = []
  assignments.each do |assignment|
    json_array << assignment.json_format
  end
  json json_array
end

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

get "/api/collaborators" do
  collaborators = Collaborator.all
  json_array = []
  collaborators.each do |collaborator|
    json_array << collaborator.json_format
  end
  json json_array
end