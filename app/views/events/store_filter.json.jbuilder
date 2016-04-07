if @event_filter.errors.empty?
  json.status :success
  json.flash_message 'Filter saved'
else
  json.status :error
  json.flash_message 'Filter could not be stored'
end
