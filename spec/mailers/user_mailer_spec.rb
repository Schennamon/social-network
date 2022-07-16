require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe 'reset_password' do
    let(:mail) { described_class.reset_password(user.id) }

    it { expect(mail.subject).to eq(I18n.t('user_mailer.reset_password.subject')) }
    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['from@example.com']) }
  end

  describe 'registration_confirmation' do
    let(:mail) { described_class.registration_confirmation(user.id) }

    it { expect(mail.subject).to eq(I18n.t('user_mailer.registration_confirmation.subject')) }
    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq(['from@example.com']) }
  end
end
