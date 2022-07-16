module Users

  module ForgotPassword

    class UpdatePasswordContract < ApplicationContract

      params do
        required(:reset_password_token).value(:string)
        required(:password).value(:string)
      end

      rule(:password).validate(:password_format)

    end

  end

end
