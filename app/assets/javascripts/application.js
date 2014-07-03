// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tinymce
//= require jquery.remotipart
//= require select2
//= require jquery_nested_form
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

jQuery(function($) {
  $("#question_tag_names").select2({
    tags: [ ],
    tokenSeparators: [","],
    maximumSelectionSize: 5,
    width: '400'
  });
});

// $(document).ready(function() {
//   $('#comment-form').hide(); 
//   $('#add-comment').click(function() {
//     $(this).preventDefault();
//     $('#comment-form').show();//Form toggles on button click
//   });
// });

// jQuery(function($) {
//   $("#new_answer").submit(function(event){
//     event.preventDefault();
//     $.ajax({
//       type: 'POST',
//       url: $(this).attr('action'),
//       data: $(this).serialize(),
//       dataType: 'json',
//       success: function(result) {
//        $('.answers').html('<%= render "questions/answers" %>');
//       }
//     });
//   });
// });