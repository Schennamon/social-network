class UserMailer < ApplicationMailer

  def registration_confirmation(user_id)
    user              = User.find(user_id)
    @confirmation_url = FrontendRouter.url_with_scheme('/email-confirmation', confirmation_token: user.confirmation_token)

    mail(to: user.email, subject: t('.subject'))
  end

  def reset_password(user_id)
    user = User.find(user_id)
    @reset_link = FrontendRouter.url_with_scheme('/reset-password', reset_password_token: user.reset_password_token)

    mail(to: user.email, subject: t('.subject'))
  end

end
