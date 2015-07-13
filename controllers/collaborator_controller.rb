get "/add_collaborator_form" do
  erb :"/collaborators/add_collaborator_form"
end

get "/add_collaborator_confirm" do
  @new_collaborator = Collaborator.add("id" => params["collaborator"]["id"].to_i), "collaborator_name" => params["collaborator"]["name"])
end