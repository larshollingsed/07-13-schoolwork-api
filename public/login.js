document.getElementById("submitter").addEventListener("click", login);

function login(event) {
  // event.preventDefault();
  
  // creates variable containing the form
  var formElement = document.getElementById("login_form");
  
  // creates new XHR request
  var request = new XMLHttpRequest();
  
  // opens new POST request
  request.open("POST", "/api/login");
  
  // sends info from form (via FormData) to previously opened POST route
  request.responseType = "json";
  request.send(new FormData(formElement));
  
  request.addEventListener("load", function() {
    var confirm = this.response.email + " has been logged in!";
    $("#confirm")[0].innerText = confirm;
  })
}