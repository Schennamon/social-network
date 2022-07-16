class ApplicationController < ActionController::API

  include Response
  include Serializable

  before_action :authenticate_request

  def current_user
    @current_user ||= set_current_user
  end

  private

  def set_current_user
    @set_current_user ||= ::AuthorizeApiRequest.new(request).call.result
  end

  def authenticate_request
    return if set_current_user

    json_response(serialized_errors(I18n.t('errors.invalid_request')), :unauthorized)
  end

end
