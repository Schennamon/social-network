module Users

  module ForgotPassword

    class UpdatePassword

      include BasicService

      attr_reader :params

      def initialize(params)
        @params = params
      end

      def call
        with_contract(::Users::ForgotPassword::UpdatePasswordContract.new, params) do |attributes|
          user = ::User.find_by(reset_password_token: attributes[:reset_password_token])

          if user.present?
            user.reset_password!(attributes[:password])
            JsonWebToken.encode(user.token_payload)
          else
            errors.add(:_base, I18n.t('errors.token.invalid'))
          end
        end
      end

    end

  end

end
