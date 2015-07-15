document.getElementById("modify_form").classList.add("hidden");

function seeAllAssignments() {

  var req = new XMLHttpRequest();
  req.open("get", "/api/assignments");

  req.addEventListener("load", function(){
    // clears previous input from previous clicks
    document.getElementById("assignments").innerText = "";
    
    for(var i = 0; i < this.response.length; i++) {
      var assignment = this.response[i]
      
      // creates specialized id for this div
      var newDivId = "assignment" + assignment.id;
      
      // creates a new li element
      var newDiv = document.createElement("li");
      
      // adds the previously created id to this specific li
      newDiv.id = newDivId
      
      // adds a custom attribute to the li of just the id for future use
      newDiv.dataId = assignment.id
      
      // adds the assignment name to the text of the li
      newDiv.innerText = assignment.assignment_name;
      
      // finds the div(which is a ul) to add the li to
      var currentDiv = document.getElementById("assignments");
      
      // adds the li to the end of the ul just found
      currentDiv.appendChild(newDiv);
      
      // adds a click functionality to the newly created li
      document.getElementById(newDivId).onclick = showAssignmentForm;
    }
  });
  req.responseType = "json";
  req.send();
}
seeAllAssignments();

function showCollaborators() {
  var req = new XMLHttpRequest();
  req.open("get", "/api/collaborators");
  
  req.addEventListener("load", function(){
    for (var x = 0; x < this.response.length; x++) {
      var collaborator = this.response[x];
      
      // creates the interpolated string of html to be inserted into the form
      var inner_html = '<input type="checkbox" class="collaborator_checkbox" id="collaborator' + collaborator.id + '" name="assignment[collaborator_id][]" value="' + collaborator.id + '"> ' + collaborator.collaborator_name
      
      // creates a new li
      var newDiv = document.createElement("li");
      
      // adds the previously sculpted html to the newly created li
      newDiv.innerHTML = inner_html;
      
      // declares the element(a ul) that the created li will be added to
      var currentDiv = document.getElementById("form_list");
      
     // adds the li to the ul
      currentDiv.appendChild(newDiv);
    }
  })
  req.responseType = "json";
  req.send();
}
showCollaborators();



function showAssignmentForm() {
  var req = new XMLHttpRequest();
  route = "/api/assignments/" + this.dataId
  req.open("get", route);

  req.addEventListener("load", function() {
    var assignment = this.response
    
    // shows the form(framework in the html but customized for the assignment
    // which was clicked on)
    document.getElementById("modify_form").classList.remove("hidden");
    
    // adds the specifics from the assignment to the fields in the form
    document.getElementById("name_field").value = assignment.assignment_name;
    document.getElementById("description_field").value = assignment.description;
    document.getElementById("repository_field").value = assignment.repository;
    document.getElementById("link_field").value = assignment.link;
    document.getElementById("assignment_id_field").value = assignment.id;
    
    // clears all of the previously checked collaborator checkboxes
    checkboxes = document.getElementsByClassName("collaborator_checkbox");
    for (var x = 0; x < checkboxes.length; x++) {
      checkboxes[x].checked = false;
    }
    
    // checks the boxes of collaborators who were previously added
    for (var x = 0; x < assignment.collaborators.length; x++) {
      // creates a variable that matches the id of each checkbox's id
      checkboxName = "collaborator" + assignment.collaborators[x]
      
      // sets checked to true if this collaborator's id was included in the
      // collaborator's array in the assignment(response) object
      document.getElementById(checkboxName).checked = true;
    }
  })
  req.responseType = "json";
  req.send();
}
document.getElementById("submitter").addEventListener("click", modifyAssignment);

function modifyAssignment(event) {
  // event.preventDefault();
  
  // creates variable containing the form
  var formElement = document.getElementById("form");
  
  // creates new XHR request
  var request = new XMLHttpRequest();
  
  // opens new POST request
  request.open("POST", "/api/modify_assignment_confirm");
  
  // sends info from form (via FormData) to previously opened POST route
  request.send(new FormData(formElement));
}