module Users

  class UpdateProfileContract < ApplicationContract

    params do
      optional(:name).filled(:string)
    end

  end

end
