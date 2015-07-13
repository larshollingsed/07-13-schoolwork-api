get "/add_collaborator_form" do
  erb :"/collaborators/add_collaborator_form"
end

get "/add_collaborator_confirm" do
  @new_collaborator = Collaborator.add({"collaborator_name" => params["collaborator"]["name"]})
  erb :"/home"
end

get "/see_all_collaborators" do
  @collaborators = Collaborator.all
  erb :"/collaborators/see_all_collaborators"
end

get "/delete_collaborator_form" do
  @collaborators = Collaborator.all
  erb :"/collaborators/delete_collaborator_form"
end

get "/delete_collaborator_confirm" do
  @deleted_collaborator = Collaborator.find(params["collaborator"]["id"])
  @deleted_collaborator.delete
  erb :"/home"
end