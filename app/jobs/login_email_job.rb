class LoginEmailJob < ApplicationJob
  queue_as :mailer, retry: 3

  def perform(*args)
  	sleep 5
    Sidekiq.logger.info 'update article visit count begin'
  end
end
