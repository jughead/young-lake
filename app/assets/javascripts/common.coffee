initDatetimePicker = () ->
  $('.js-datetime-picker').datetimepicker(
    format: 'DD.MM.YYYY HH:mm:ss'
  )

$(document).on 'page:load ready', () ->
  initDatetimePicker()
