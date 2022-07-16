require 'rails_helper'

RSpec.describe ErrorsSerializer do
  describe '.serializable_hash' do
    context 'with a string' do
      it 'return _base error' do
        value = described_class.new('Base error').serializable_hash
        expect(value).to eq({
                              errors: { _base: 'Base error' }
                            })
      end
    end

    context 'with a hash' do
      it 'return errors object' do
        value = described_class.new({ email: 'error', password_confirmation: ['invalid'] }).serializable_hash
        expect(value).to eq({ errors: { email: 'error', password_confirmation: 'invalid' } })
      end
    end

    context 'with a SimpleCommand::Errors object' do
      it 'return errors object' do
        errors = SimpleCommand::Errors.new
        errors.add(:email, 'error')

        value = described_class.new(errors).serializable_hash
        expect(value).to eq({ errors: { email: 'error' } })
      end
    end

    context 'with something else' do
      it 'return empty object' do
        expect(described_class.new(nil).serializable_hash).to eq({ errors: {} })
      end
    end
  end
end
