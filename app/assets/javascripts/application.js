// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  $('#sign-in').click(function () {
    //Conditional states allow the dropdown box appear and disappear 
    if ($('#signin-dropdown').is(":visible")) {
      $('#signin-dropdown').hide()
    $('#session').removeClass('active'); // When the dropdown is not visible removes the class "active"
  } else {
    $('#signin-dropdown').show()
    $('#session').addClass('active'); // When the dropdown is visible add class "active"
  }
  return false;
});
  $('#signin-dropdown').click(function(e) {
    e.stopPropagation();
  });
  $(document).click(function() {
    $('#signin-dropdown').hide();
    $('#session').removeClass('active');
  });
});
function setCurrentStock (callbackFunction) {
  $.ajax({
    url: document.location,
    dataType: 'json',
    success: function (data) {
     console.log(data)

     if (callbackFunction) {
      callbackFunction();
    };
  }
});
};

setCurrentStock();


