require 'jwt'

class JsonWebToken

  class << self

    def encode(payload)
      payload.reverse_merge!(meta)
      JWT.encode(payload, Rails.application.credentials[:secret_key_base])
    end

    def decode(token)
      JWT.decode(token, Rails.application.credentials[:secret_key_base])
    end

    def valid_payload(payload)
      not_expired(payload)
    end

    def meta
      { exp: 7.days.from_now.to_i }
    end

    # Validates if the token is expired by exp parameter
    def not_expired(payload)
      Time.zone.at(payload['exp']) > Time.zone.now
    end

  end

end
