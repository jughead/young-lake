initResetThemeClick = () ->
  $(document).on 'click', '.js-reset-event-filter-theme', (event) ->
    $this = $(@)
    $this.closest('.form-group').find(':input').attr('checked', false).change()

initDatePickerObserver = () ->
  $('.js-datetime-picker :input').filterrific_observe_field(0.5, Filterrific.submitFilterForm)

initResetThemeClick()

$(document).on 'page:load ready', () ->
  initDatePickerObserver()

