var users = $.getJSON("/api/see_users", function() {
  users = users.responseJSON;
});

document.getElementById("submitter").addEventListener("click", addUser);

function addUser(event) {
  // event.preventDefault();
  
  // creates variable containing the form
  var formElement = document.getElementById("add_user_form");
  
  // creates new XHR request
  var request = new XMLHttpRequest();
  
  // opens new POST request
  request.open("POST", "/api/add_user");
  
  // sends info from form (via FormData) to previously opened POST route
  request.responseType = "json";
  request.send(new FormData(formElement));
  
  request.addEventListener("load", function() {
    var confirm = this.response.email + " has been registered!";
    $("#confirm")[0].innerText = confirm;
  })
}