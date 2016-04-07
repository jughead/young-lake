initResetThemeClick = () ->
  $(document).on 'click', '.js-reset-event-filter-theme', (event) ->
    $this = $(@)
    $this.closest('.form-group').find(':input').attr('checked', false).change()

initDatePickerObserver = () ->
  $('.js-datetime-picker :input').filterrific_observe_field(0.5, Filterrific.submitFilterForm)

initSaveFilterButton = () ->
  $(document).on 'click', '.js-save-filter', (event) ->
    event.preventDefault()
    $this = $(@)
    $.ajax({
      url: $this.data('url')
      method: 'POST'
      data: $this.closest('form').serialize()
      dataType: 'json'
      success: (data) ->
        console.log 'asdasd'
        console.log data
        if data.status == 'success'
          Meyvn.Flash.success(data.flash_message)
        else
          Meyvn.Flash.error(data.flash_message)
      error: (event) ->
        Meyvn.Flash.error('Please try again later')
    })


initResetThemeClick()

$(document).on 'page:load ready', () ->
  initDatePickerObserver()
  initSaveFilterButton()

