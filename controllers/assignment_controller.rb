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
  @assignment = Assignment.find(params["assignment_id"].to_i)
  @collaborators_worked = @assignment.find_collaborators
  @collaborators = Collaborator.all
  erb :"/assignments/modify_assignment_form2"
end

get "/modify_assignment_confirm" do 
  @modified_assignment = Assignment.new({"id" => params["assignment"]["id"], "assignment_name" => params["assignment"]["name"], "link" => params["assignment"]["link"], "repository" => params["assignment"]["repository"], "description" => params["assignment"]["description"]})
  @modified_assignment.save
  @modified_assignment.delete_collaborations
  @modified_assignment.add_to_collaborations(params["assignment"]["collaborator_id"])
  erb :"home"
end
  
get "/delete_assignment_form" do
  @assignments = Assignment.all
  erb :"/assignments/delete_assignment_form"
end

get "/delete_assignment_confirm" do
  @deleted_assignment = Assignment.find(params["assignment_id"].to_i)
  @deleted_assignment.delete_collaborations
  @deleted_assignment.delete
  erb :"home"
end

get "/see_all_assignments" do
  @assignments = Assignment.all
  @collaborators = Collaborator.all
end

