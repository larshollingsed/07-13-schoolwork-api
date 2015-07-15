function seeAllCollaborators(event) {

  
  var req = new XMLHttpRequest();
  req.open("get", "/api/collaborators");
  
  req.addEventListener("load", function(){
    
    for(var i = 0; i < this.response.length; i++) {
      var collaborator = this.response[i]
      var newDivId = "collaborator" + collaborator.id;
      var newDiv = document.createElement("li");
      newDiv.id = newDivId
      newDiv.dataId = collaborator.id
      newDiv.innerText = collaborator.collaborator_name;
      var currentDiv = document.getElementById("collaborator_list");
      currentDiv.appendChild(newDiv);
      newDiv.onclick = showCollaborations;
    }
  });
  req.responseType = "json";
  req.send();
}
seeAllCollaborators();

function showCollaborations(event) {
  event.preventDefault();
  var req = new XMLHttpRequest();
  var route = "/api/collaborators/" + this.dataId;
  req.open("get", route);
  // var currentDiv = document.getElementById("collaborations_list");
  var title = "You have worked on the following assignments with " + this.innerText;
  document.getElementById("your_collaborator").innerText = title;
  // var newDiv = document.createElement("lh");
  // newDiv.innerText = title;
  // currentDiv.appendChild(newDiv);
  
  req.addEventListener("load", function() {
    var currentDiv = document.getElementById("collaborations_list");
    currentDiv.innerText = "";
    for (var x = 0; x < this.response.length; x++) {
      var assignment = this.response[x];

      var newDiv = document.createElement("li");
      var name_of_assignment = '<p class="assignment_key assignment_name">' + assignment.assignment_name + "</p>";
      var description = '<p class="assignment_key"> Description - </p><p>' + assignment.description + "</p>";
      var repository = '<p class="assignment_key"> Github Repository Link - </p><a href="' + assignment.repository + '">' + assignment.repository + '</a>';
      
      
      
      var inner_html = name_of_assignment + description + repository;
      newDiv.innerHTML = inner_html;
      currentDiv.appendChild(newDiv);
      
    }
      
    
    
  })
  
  req.responseType = "json";
  req.send();
}