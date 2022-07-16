module Api

  module V1

    module Users

      class AuthenticationsController < ApplicationController

        skip_before_action :authenticate_request

        def create
          command = ::AuthenticateUser::WithCredentials.new(params[:authentication].to_unsafe_hash).call

          if command.success?
            json_response(jwt_token: command.result)
          else
            json_response(serialized_errors(command.errors), :unauthorized)
          end
        end

      end

    end

  end

end
