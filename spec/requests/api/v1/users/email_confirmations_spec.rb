require 'swagger_helper'

RSpec.describe '/api/v1/users/email_confirmation', type: :request do
  let!(:user) { create(:user) }

  path '/api/v1/users/email_confirmation' do
    post 'Create confirmation' do
      tags 'Users'

      description 'Confirm user after clicking on the link in the email'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          confirmation_token: { type: :string }
        },
        required: %w[confirmation_token]
      }

      response(200, 'successful') do
        let(:body) do
          { confirmation_token: user.confirmation_token }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['jwt_token'].present?).to be(true)
          expect(response_body['message']).to eq('You have confirmed your email')
        end
      end

      response(422, 'unprocessable entity') do
        let(:body) do
          { confirmation_token: 'sample' }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['_base']).to eq('Invalid token')
        end
      end
    end
  end
end
