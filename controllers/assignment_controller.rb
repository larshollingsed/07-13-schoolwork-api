get "/" do
  erb :"home"
end

get "/add_assignment_form" do
  @collaborators = Collaborator.all
  erb :"/assignments/add_assignment_form"
end

get "/add_assignment_confirm" do
  @new_assignment = Assignment.add({"assignment_name" => params["assignment"]["name"], "link" => params["assignment"]["link"], "repository" => params["assignment"]["repository"], "description" => params["assignment"]["description"]})
  @new_assignment.add_to_collaborations(params["assignment"]["collaborator_id"])
  erb :"home"
end

get "/modify_assignment_form1" do
  @assignments = Assignment.all
  erb :"/assignments/modify_assignment_form1"
end

get "/modify_assignment_form2" do
  @assignment = Assignment.find(params["assignment"])