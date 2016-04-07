window.Meyvn ||= {}
window.Meyvn.Flash = class Flash
  @success: (message) ->
    $('#notice').removeClass('hide').show().html(message).fadeOut(2000)
  @error: (message) ->
    $('#error').removeClass('hide').show().html(message).fadeOut(5000)

initDatetimePicker = () ->
  $('.js-datetime-picker').datetimepicker(
    format: 'DD.MM.YYYY HH:mm:ss'
  )

$(document).on 'page:load ready', () ->
  initDatetimePicker()
