# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    event.preventDefault()
    $(this).prev('input[type=hidden]').val('true')
    $(this).closest('fieldset').hide()
    $(this).closest('fieldset').prev('.undo_remove').show()

  $('form').on 'click', '.add_fields', (event) ->
    event.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(".actions").before($(this).data('fields').replace(regexp, time))
    $("[id$=" + time.toString() + "_order]").val(time)

  $('form').on 'click', '.undo_remove', (evenet) ->
    event.preventDefault()
    $(this).next('fieldset').children('input[type=hidden]').val('false')
    $(this).next('fieldset').show()
    $(this).hide()