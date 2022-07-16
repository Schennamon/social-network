module Confirmable

  extend ActiveSupport::Concern

  included do
    has_secure_token :confirmation_token
  end

  def confirm!
    self.confirmed_at = Time.zone.now
    self.confirmation_token = nil
    save!
  end

  def confirmed?
    confirmed_at.present?
  end

end
