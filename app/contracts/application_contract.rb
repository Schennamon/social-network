class ApplicationContract < Dry::Validation::Contract

  config.messages.backend = :i18n

  EMAIL_REGEXP    = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PASSWORD_REGEXP = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/

  register_macro(:email_format) do
    key.failure('has invalid format') unless EMAIL_REGEXP.match?(value)
  end

  register_macro(:password_format) do
    unless PASSWORD_REGEXP.match?(value)
      key.failure('must be between 8 and 50 characters, contains letters and numbers')
    end
  end

  register_macro(:record_exists?) do |macro:|
    model = macro.args[0]
    key.failure('not exist') unless model.exists?(value)
  end

end
