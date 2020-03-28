//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require maskedinput
//= require raphael
//= require bootstrap
//= require serviceworker-companion
//= require morris
//= require_tree .

$( document ).on('turbolinks:load', function() {
	var $doc = $('html, body');
  $('.navegacao a[href^="#"]').click(function() {
      $doc.animate({
          scrollTop: $( $.attr(this, 'href')).offset().top
      }, 500);
      return false;
  });

  $('.carousel').carousel({
  	interval: 3000
  });

  $(function() {
    setTimeout(function(){
      $('.alert').slideUp(500);
    }, 2500);
  });
});
