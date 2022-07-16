class FrontendRouter

  PROTOCOL = %w[staging production].include?(Rails.env) ? 'https://' : 'http://'
  HOST     = Rails.application.credentials.application_url

  def self.default_url
    result = PROTOCOL
    result += HOST

    result
  end

  def self.url_with_scheme(path, query_params = {})
    result = PROTOCOL
    result += url(path, query_params)

    result
  end

  def self.url(path, query_params = {})
    result = HOST
    result += path(path, query_params)

    result
  end

  def self.path(path, query_params = {})
    result = ''
    result += "/#{I18n.locale}" if I18n.default_locale != I18n.locale

    if path.remove('/').present?
      result += path.start_with?('/') ? path : "/#{path}"
    end

    result += '?' if query_params.present?
    result += query_params.to_a.map { |k, v| "#{k}=#{v}" }.join('&')

    result
  end

end
