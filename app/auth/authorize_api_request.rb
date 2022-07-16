class AuthorizeApiRequest

  include BasicService

  attr_reader :headers

  def initialize(request)
    @headers = request.headers
  end

  def call
    ::User.find_by(id: payload['id']) if payload.present?
  end

  private

  def payload
    JsonWebToken.decode(headers['Authorization'].split.last).first
  rescue StandardError
    nil
  end

end
