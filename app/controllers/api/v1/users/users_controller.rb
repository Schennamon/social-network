module Api

  module V1

    module Users

      class UsersController < ApplicationController

        skip_before_action :authenticate_request, only: :create

        def show
          json_response(UserSerializer.new(current_user).serializable_hash)
        end

        def create
          command = ::Users::CreateProfile.new(params[:user].to_unsafe_hash).call

          if command.success?
            json_response(UserSerializer.new(command.result).serializable_hash)
          else
            json_response(serialized_errors(command.errors), :not_acceptable)
          end
        end

        def update
          command = ::Users::UpdateProfile.new(current_user, params[:user].to_unsafe_hash).call

          if command.success?
            json_response(UserSerializer.new(command.result).serializable_hash)
          else
            json_response(serialized_errors(command.errors), :not_acceptable)
          end
        end

        def destroy
          command = ::Users::DeleteAccount.new(current_user).call

          if command.success?
            json_response(message: I18n.t('users.deleted'))
          else
            json_response(serialized_errors(command.errors), :unprocessable_entity)
          end
        end

      end

    end

  end

end
