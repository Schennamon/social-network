require 'frontend_router'

class ApplicationMailer < ActionMailer::Base

  default from: 'from@example.com'
  layout 'mailer'

end
