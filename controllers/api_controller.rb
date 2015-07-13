get "/api/assignments" do
  assignments = Assignment.all
  json_array = []
  assignments.each do |assignment|
    json_array << assignment.json_format
  end
  json json_array
end