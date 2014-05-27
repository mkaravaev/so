# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  $('form#new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON xhr.responseText
    $('.answers').append('<hr>')
    $('.answers').append('<p>' + answer.body + '</p>')
    $.each answer.attachments, (index, attachment) ->
      $('.answers').append('<small> Attachment: ' + '<a href="' + attachment.url + '">' + attachment.name + '</a></small>')
    $('.answers').append('<small><a class="edit-answer-link" data-answer-id="' + answer.id + '" href="">Edit</a></small>')  
    $('.answers').append('<br>')
    $('.answers').append('<small><a data-confirm="Delete your answer?" data-method="delete" href="/questions/' + answer.question_id + '/answers/' + answer.id + '" rel="nofollow">Delete</a></small>')  
    $('#answer_body').val('')  

  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.answer-errors').append(value)
