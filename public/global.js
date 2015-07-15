if (document.body.attributes.data_page_name.value === "home page") {
  function seeAllAssignments(event) {
    event.preventDefault();
    
    var req = new XMLHttpRequest();
    req.open("get", "/api/assignments");
    
    req.addEventListener("load", function(){
      document.getElementById("assignments").innerText = "";
      for(var i = 0; i < this.response.length; i++) {
        var assignment = this.response[i]
        var newDivId = "assignment" + assignment.id;
        var newDiv = document.createElement("li");
        newDiv.id = newDivId
        newDiv.dataId = assignment.id
        newDiv.innerText = assignment.assignment_name;
        var currentDiv = document.getElementById("assignments");
        currentDiv.appendChild(newDiv);
        document.getElementById(newDivId).onclick = showAssignment;
        
        
        // document.body.insertBefore(newDiv, currentDiv.lastChild);
      }
    });
    req.responseType = "json";
    req.send();
  }
  
  document.getElementById("see_all_assignments").onclick = seeAllAssignments;
  
  function showAssignment(event) {
    event.preventDefault();
    var req = new XMLHttpRequest();
    var route = "/api/assignments/" + this.dataId;
    req.open("get", route);
    
    req.addEventListener("load", function(){
      var assignment = this.response
      document.getElementById("assignments").innerText = "";
      
      var newDiv = document.createElement("li");
      newDiv.innerText = "Assignment Name - " + assignment.assignment_name;
      var currentDiv = document.getElementById("assignments");
      currentDiv.appendChild(newDiv);
      
      var newDiv = document.createElement("li");
      newDiv.innerText = "Assignment Description - " + assignment.description;
      var currentDiv = document.getElementById("assignments");
      currentDiv.appendChild(newDiv);
      
      var newDiv = document.createElement("a");
      newDiv.innerText = "Assignment Repository - " + assignment.repository;
      newDiv.href = assignment.repository
      var currentDiv = document.getElementById("assignments");
      currentDiv.appendChild(newDiv);
      
    })
    req.responseType = "json";
    req.send();
  }
}

if (document.body.attributes.data_page_name.value === "modify assignment") {
  document.getElementById("modify_form").classList.add("hidden");
  
  function seeAllAssignments() {
  
    var req = new XMLHttpRequest();
    req.open("get", "/api/assignments");
  
    req.addEventListener("load", function(){
      document.getElementById("assignments").innerText = "";
      for(var i = 0; i < this.response.length; i++) {
        var assignment = this.response[i]
        var newDivId = "assignment" + assignment.id;
        var newDiv = document.createElement("li");
        newDiv.id = newDivId
        newDiv.dataId = assignment.id
        newDiv.innerText = assignment.assignment_name;
        var currentDiv = document.getElementById("assignments");
        currentDiv.appendChild(newDiv);
        document.getElementById(newDivId).onclick = showAssignmentForm;
      
      
        // document.body.insertBefore(newDiv, currentDiv.lastChild);
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
        var inner_html = '<input type="checkbox" class="collaborator_checkbox" id="collaborator' + collaborator.id + '" name="assignment[collaborator_id][]" value="' + collaborator.id + '"> ' + collaborator.collaborator_name
        
        var newDiv = document.createElement("li");
        newDiv.innerHTML = inner_html;
        
        var currentDiv = document.getElementById("form_list");
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
      document.getElementById("modify_form").classList.remove("hidden");
      document.getElementById("name_field").value = this.response.assignment_name;
      document.getElementById("description_field").value = this.response.description;
      document.getElementById("repository_field").value = this.response.repository;
      document.getElementById("link_field").value = this.response.link;
      document.getElementById("assignment_id_field").value = this.response.id;
      
      checkboxes = document.getElementsByClassName("collaborator_checkbox");
      for (var x = 0; x < checkboxes.length; x++) {
        checkboxes[x].checked = false;
      }
      
      for (var x = 0; x < this.response.collaborators.length; x++) {
        checkboxName = "collaborator" + this.response.collaborators[x]
        document.getElementById(checkboxName).checked = true;
      }
    })
    req.responseType = "json";
    req.send();
  }
  document.getElementById("submitter").addEventListener("click", modifyAssignment);
  
  function modifyAssignment(event) {
    event.preventDefault();
    // event.stopPropagation();
    var formElement = document.getElementById("form");
    var request = new XMLHttpRequest();
    request.open("POST", "/api/modify_assignment_confirm");
    request.send(new FormData(formElement));
  }
   
}

