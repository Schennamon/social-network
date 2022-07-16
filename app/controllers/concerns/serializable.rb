module Serializable

  def serialized_errors(errors)
    ErrorsSerializer.new(errors).serializable_hash
  end

end
