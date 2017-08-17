// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap.min
//= require_tree .

// @import "font-awesome-sprockets";
// @import "font-awesome";


function submit() {
  debugger
  return $.post({
    user = $("#user_id").val();
    album = $("#album_id").val();
    url: "/users/" + user+ "/albums/" + album + "/comments/remark",
    data: {
      product: {
        name: "Album-app",
        description: "whatever"
      }
    },
    dataType: "json",
    success: function(data) {
      return alert(cmts.id);
    }
  });
}