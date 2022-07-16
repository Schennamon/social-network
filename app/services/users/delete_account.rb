module Users

  class DeleteAccount

    include BasicService

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      user.destroy
    end

  end

end
