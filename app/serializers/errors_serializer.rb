class ErrorsSerializer

  attr_reader :error

  def initialize(error)
    @error = error
  end

  def serializable_hash
    return activerecord_serializer if error.is_a? ActiveModel::Errors
    return hash_serializer         if error.is_a?(Hash)
    return string_serializer       if error.is_a? String

    { errors: {} }
  end

  private

  def string_serializer
    {
      errors: { _base: error }
    }
  end

  def hash_serializer
    {
      errors: error.transform_values { |value| [*value].join(', ') }
    }
  end

  def activerecord_serializer
    errors = {}
    error.each do |key, message|
      errors[key] = error.full_message(key, message)
    end
    { errors: errors }
  end

end
