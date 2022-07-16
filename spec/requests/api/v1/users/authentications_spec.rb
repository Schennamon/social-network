require 'swagger_helper'

RSpec.describe '/api/v1/users/authentication', type: :request do
  let(:password) { SecureRandom.hex(10) }
  let(:user)     { create(:user, :confirmed, password: password) }
  let(:user1)    { create(:user) }

  path '/api/v1/users/authentication' do
    post 'Authentication' do
      tags 'Users'

      description 'Authentication with email and password'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          authentication: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        },
        required: %w[authentication]
      }

      response(200, 'successful') do
        let(:body) do
          { authentication: { email: user.email, password: password } }
        end

        run_test!
      end

      response(401, 'email not confirmed') do
        let(:body) do
          { authentication: { email: user1.email, password: user1.password } }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['_base']).to eq('Plese confirm your email')
        end
      end
    end
  end
end
