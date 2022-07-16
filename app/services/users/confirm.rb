module Users

  class Confirm

    include BasicService

    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def call
      user if confirm
    end

    private

    def user
      @user ||= User.find_by(confirmation_token: token)
    end

    def confirm
      return if user.nil?

      user.confirm!
    end

  end

end
