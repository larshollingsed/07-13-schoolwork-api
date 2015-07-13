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