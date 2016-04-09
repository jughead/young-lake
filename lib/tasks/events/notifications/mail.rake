namespace :events do
  namespace :notifications do
    desc 'Sends all unread notification via email'
    task :mail => :environment do
      attempts = ENV['RETRY'] || 5
      EventNotificationMailSender.set(retry: attempts).perform_now
    end
  end
end
