module Users

  class CreateProfileContract < ApplicationContract

    params do
      required(:email).filled(:string)
      required(:password).filled(:string)
    end

    rule(:email).validate(:email_format)

    rule(:email) do
      key.failure('has already been taken') if User.find_by(email: value.downcase).present?
    end

    rule(:password).validate(:password_format)

  end

end
