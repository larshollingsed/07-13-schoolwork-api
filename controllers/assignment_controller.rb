get "/" do
  erb :"home"
end

get "/add_assignment_form" do
  @collaborators = Collaborator.all
  erb :"/assignments/add_assignment_form"
end

get "/add_assignment_confirm" do
  @new_assignment = Assignment.add({"assignment_name" => params["assignment"]["name"], "link" => params["assignment"]["link"], "repository" => params["assignment"]["repository"], "description" => params["assignment"]["description"]})
  erb :"home"
end
  