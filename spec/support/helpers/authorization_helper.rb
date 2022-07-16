module AuthorizationHelper

  def authorization(user)
    JsonWebToken.encode(user.token_payload)
  end

end
