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
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery.js
//= require popper
//= require bootstrap-sprockets
//= require jquery-ui
//= require tag-it
//= require_tree .


$(document).on('click', '#test_user_login_btn', function() {
  var login_email = 'test@test.com';
  var login_password = '123456';

  var login_email_form = document.querySelector('#user_email');
  var login_password_form = document.querySelector('#user_password');

  login_email_form.value = login_email;
  login_password_form.value = login_password;

  document.querySelector('#login_btn').click();
  
});