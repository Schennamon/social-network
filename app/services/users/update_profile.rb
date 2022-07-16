module Users

  class UpdateProfile

    include BasicService

    attr_reader :user, :params

    def initialize(current_user, params)
      @user   = current_user
      @params = params
    end

    def call
      with_contract(::Users::UpdateProfileContract.new, params) do |attributes|
        if attributes.present?
          add_errors_for(user) unless user.update(attributes)
        else
          errors.add(:_base, I18n.t('errors.cannot_update'))
        end

        user
      end
    end

  end

end
