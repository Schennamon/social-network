module Users

  module ForgotPassword

    class StartResetPasswordProcess

      include BasicService

      attr_reader :email

      def initialize(email)
        @email = email
      end

      def call
        with_contract(::Users::ForgotPassword::StartResetPasswordProcessContract.new, { email: email }) do |attributes|
          user = User.find_by(email: attributes[:email].downcase)

          if user.present?
            start_reset_password_process(user)
          else
            errors.add(:_base, I18n.t('errors.wrong_email'))
          end
        end
      end

      private

      def start_reset_password_process(user)
        return errors.add(:_base, I18n.t('errors.confirm')) unless user.confirmed?

        user.generate_password_token!
        UserMailer.reset_password(user.id).deliver_later
      end

    end

  end

end
