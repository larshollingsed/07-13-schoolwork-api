var req = new XMLHttpRequest();

function seeAllAssignments(event) {
  // event.preventDefault();
  req.open("get", "/api/assignments");

  req.addEventListener("load", function(){
  for(var i = 0; i < this.response.length; i++) {
    var newDivName = "assignment" + this.response[i].id;
    var newDiv = document.createElement(newDivName);
    newDiv.innerHtml = this.response[i].assignment_name;
    
    var currentDiv = document.getElementById("main");
    document.body.insertBefore(newDiv, currentDiv.nextSibling);
  }
})
req.responseType = "json";
req.send();
}


document.getElementById("see_all_assignments").onclick = seeAllAssignments();