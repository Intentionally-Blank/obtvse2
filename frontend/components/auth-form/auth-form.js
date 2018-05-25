import "./auth-form.css";

$(document).ready(function () {
  var hash = window.location.hash.substr(1);

  var result = hash.split('&').reduce(function (result, item) {
    var parts = item.split('=');
    result[parts[0]] = parts[1];
    return result;
    }, {});

  $("#jwt").val(result["id_token"])

});

