function seeAllCollaborators(event) {
  
  var req = new XMLHttpRequest();
  req.open("get", "/api/collaborators");
  
  req.addEventListener("load", function(){
    
    for(var i = 0; i < this.response.length; i++) {
      // simplifies which object from the JS array to be worked with
      var collaborator = this.response[i]
      
      // creates a new div with ID and custom 'dataId' and the collaborator's name
      var newDivId = "collaborator" + collaborator.id;
      var newDiv = document.createElement("li");
      newDiv.id = newDivId
      newDiv.dataId = collaborator.id
      newDiv.innerText = collaborator.collaborator_name;
      
      // finds existing div to insert new div into (at the end of its children)
      var currentDiv = document.getElementById("collaborator_list");
      currentDiv.appendChild(newDiv);
      
      // also turns each LI into a clickable event
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
  
  // opens route specific to the collaborator who was clicked on via dataId
  var route = "/api/collaborators/" + this.dataId;
  req.open("get", route);
  
  // creates title for assignments with specific collaborator
  var title = "You have worked on the following assignments with " + this.innerText;
  document.getElementById("your_collaborator").innerText = title;

  
  req.addEventListener("load", function() {
    // clears div of any from any previous clicks on other collaborators 
    var currentDiv = document.getElementById("collaborations_list");
    currentDiv.innerText = "";
    
    for (var x = 0; x < this.response.length; x++) {
      // simplifies which object in the response we are working with in the loop
      var assignment = this.response[x];

      // creates a new li element to be added to the end of a blank ul
      var newDiv = document.createElement("li");
      
      // creates <p>s of various assignment parameters and stores as variables
      var name_of_assignment = '<p class="assignment_key assignment_name">' + assignment.assignment_name + "</p>";
      var description = '<p class="assignment_key"> Description - </p><p>' + assignment.description + "</p>";
      var repository = '<p class="assignment_key"> Github Repository Link - </p><a href="' + assignment.repository + '">' + assignment.repository + '</a>';
      
      // adds the previously created <p>s to inside of the newly created li
      var inner_html = name_of_assignment + description + repository;
      newDiv.innerHTML = inner_html;
      
      // adds li to the end of the assignments div
      currentDiv.appendChild(newDiv);
      
    }
      
    
    
  })
  
  req.responseType = "json";
  req.send();
}