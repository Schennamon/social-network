module Users

  class AuthenticationWithCredentialsContract < ApplicationContract

    params do
      required(:email).filled(:string)
      required(:password).filled(:string)
    end

    rule(:email).validate(:email_format)
    rule(:password).validate(:password_format)

  end

end
