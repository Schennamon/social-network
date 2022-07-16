module Users

  class CreateProfile

    include BasicService

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      with_contract(::Users::CreateProfileContract.new, params) do |attributes|
        user = User.new(attributes)

        UserMailer.registration_confirmation(user.id).deliver_later if user.save

        user
      end
    end

  end

end
