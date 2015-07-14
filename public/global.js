function seeAllAssignments(event) {
  event.preventDefault();
  
  var req = new XMLHttpRequest();
  req.open("get", "/api/assignments");
  
  req.addEventListener("load", function(){
    document.getElementById("assignments").innerText = "";
    for(var i = 0; i < this.response.length; i++) {
      var newDivId = "assignment" + this.response[i].id;
      var newDiv = document.createElement("li");
      newDiv.id = newDivId
      newDiv.innerText = this.response[i].assignment_name;
      var currentDiv = document.getElementById("assignments");
      currentDiv.appendChild(newDiv);
      
      
      // document.body.insertBefore(newDiv, currentDiv.lastChild);
    }
  });
  req.responseType = "json";
  req.send();
}
document.getElementById("see_all_assignments").onclick = seeAllAssignments;

function seeAllCollaborators(event) {
  event.preventDefault();
  
  var req = new XMLHttpRequest()
  
}