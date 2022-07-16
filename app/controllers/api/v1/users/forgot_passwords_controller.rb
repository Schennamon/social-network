module Api

  module V1

    module Users

      class ForgotPasswordsController < ApplicationController

        skip_before_action :authenticate_request

        def create
          command = ::Users::ForgotPassword::StartResetPasswordProcess.new(params[:email]).call

          if command.success?
            head :ok
          else
            json_response(serialized_errors(command.errors), :unauthorized)
          end
        end

        def update
          command = ::Users::ForgotPassword::UpdatePassword.new(params[:forgot_password].to_unsafe_hash).call

          if command.success?
            json_response(jwt_token: command.result, message: I18n.t('users.password_updated'))
          else
            json_response(serialized_errors(command.errors), :unprocessable_entity)
          end
        end

      end

    end

  end

end
