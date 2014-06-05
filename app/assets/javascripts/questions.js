$(function() {
  return $('.edit-question-link').click(function(e) {
    e.preventDefault();
    $(this).hide();
    return $('.question_form').show("slow")
  });
});