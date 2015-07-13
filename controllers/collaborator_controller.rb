get "/add_collaborator_form" do
  erb :"/collaborators/add_collaborator_form"
end

get "/add_collaborator_confirm" do
  @new_collaborator = Collaborator.add({"collaborator_name" => params["collaborator"]["name"]})
end