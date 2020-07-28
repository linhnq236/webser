class ApplicationMailer < ActionMailer::Base
  helper :services
  helper :application
  default from: "#{ENV["USER_MAIL"]}"
  layout 'mailer'
end
