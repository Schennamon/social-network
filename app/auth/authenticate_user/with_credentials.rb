module AuthenticateUser

  class WithCredentials

    include BasicService

    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def call
      with_contract(::Users::AuthenticationWithCredentialsContract.new, params) do |attributes|
        email    = attributes[:email]
        password = attributes[:password]
        user     = User.find_by(email: email.downcase)

        if user.present? && user.authenticate(password)
          create_jwt_token(user)
        else
          errors.add(:_base, I18n.t('errors.password.invalid'))
        end
      end
    end

    private

    def create_jwt_token(user)
      return errors.add(:_base, I18n.t('errors.confirm')) unless user.confirmed?

      JsonWebToken.encode(user.token_payload)
    end

  end

end
