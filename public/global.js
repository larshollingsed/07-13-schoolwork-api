function seeAllAssignments(event) {
  event.preventDefault();
  
  var req = new XMLHttpRequest();
  req.open("get", "/api/assignments");
  
  req.addEventListener("load", function(){
    for(var i = 0; i < this.response.length; i++) {
      var newDivId = "assignment" + this.response[i].id;
      var newDiv = document.createElement("p");
      newDiv.id = newDivId
      newDiv.innerText = this.response[i].assignment_name;
      var currentDiv = document.getElementById("assignments");
      currentDiv.parentNode.insertBefore(newDiv, currentDiv.lastSibling);
      
      
      // document.body.insertBefore(newDiv, currentDiv.lastChild);
    }
  });
  req.responseType = "json";
  req.send();
}
document.getElementById("see_all_assignments").onclick = seeAllAssignments;