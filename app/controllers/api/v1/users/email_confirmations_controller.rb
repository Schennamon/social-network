module Api

  module V1

    module Users

      class EmailConfirmationsController < ApplicationController

        skip_before_action :authenticate_request

        def create
          user = ::Users::Confirm.new(params[:confirmation_token]).call.result

          if user.present?
            jwt_token = JsonWebToken.encode(user.token_payload)
            json_response(jwt_token: jwt_token, message: I18n.t('users.confirmed_email'))
          else
            json_response(serialized_errors(I18n.t('errors.token.invalid')), :unprocessable_entity)
          end
        end

      end

    end

  end

end
