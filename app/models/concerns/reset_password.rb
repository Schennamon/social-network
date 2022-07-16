module ResetPassword

  extend ActiveSupport::Concern

  included do
    has_secure_password
  end

  def generate_password_token!
    self.reset_password_token = SecureRandom.hex(10)
    self.reset_password_sent_at = Time.zone.now
    save!
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.reset_password_sent_at = Time.zone.now
    self.password = password
    save!
  end

end
