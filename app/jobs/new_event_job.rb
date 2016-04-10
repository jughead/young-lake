class NewEventJob < ActiveJob::Base
  def perform(event)
    EventFilter.matching(event).includes(:user).find_each do |filter|
      # NOTE: возможно стоит проверять, что EventNotification уже существует, чтобы не генерить попусту задачи
      NewEventMatchingFilterJob.perform_later(filter.user, event)
    end
  end
end
