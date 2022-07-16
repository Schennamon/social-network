module Users

  module ForgotPassword

    class StartResetPasswordProcessContract < ApplicationContract

      params do
        required(:email).value(:string)
      end

      rule(:email).validate(:email_format)

    end

  end

end
