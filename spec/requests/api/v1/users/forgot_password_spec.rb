require 'swagger_helper'

RSpec.describe '/api/v1/users/forgot_password', type: :request do
  let(:new_password)         { SecureRandom.hex(10) }
  let(:user)                 { create(:user, :confirmed, password: password) }
  let(:user1)                { create(:user) }
  let(:user2)                { create(:user, reset_password_token: SecureRandom.hex(10)) }
  let(:reset_password_token) { user2.reset_password_token }

  path '/api/v1/users/forgot_password' do
    post 'Create reset_password_token' do
      tags 'Users'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, required: true, schema: {
        type: :object, properties: { email: { type: :string } }, required: %w[email]
      }

      response(200, 'successful') do
        let(:body) do
          { email: user.email }
        end
      end

      response(401, 'email not confirmed') do
        let(:body) do
          { email: user1.email }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['_base']).to eq('Plese confirm your email')
        end
      end

      response(401, 'invalid email') do
        let(:body) do
          { email: 'wrong_email' }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['email']).to eq('Email has invalid format')
        end
      end
    end
  end

  path '/api/v1/users/forgot_password' do
    put 'Update Password' do
      tags 'Users'

      consumes 'application/json'
      produces 'application/json'

      security [jwt: []]

      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          forgot_password: {
            type: :object,
            properties: {
              reset_password_token: { type: :string },
              password: { type: :string }
            },
            required: %w[reset_password_token password]
          }
        },
        required: %w[forgot_password]
      }

      response(200, 'successful') do
        let(:Authorization) { authorization(user2) }

        let(:body) do
          {
            forgot_password: {
              reset_password_token: reset_password_token,
              password: new_password
            }
          }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['jwt_token'].present?).to be(true)
        end
      end

      response(422, 'invalid password') do
        let(:Authorization) { authorization(user2) }

        let(:body) do
          {
            forgot_password: {
              reset_password_token: reset_password_token,
              password: 'invalid'
            }
          }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['password']).to eq('Password must be between 8 and 50 characters, contains letters and numbers')
        end
      end

      response(422, 'invalid token') do
        let(:Authorization) { authorization(user2) }

        let(:body) do
          {
            forgot_password: {
              reset_password_token: 'invalid',
              password: new_password
            }
          }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['_base']).to eq('Invalid token')
        end
      end

      response(422, 'missing params') do
        let(:Authorization) { authorization(user2) }

        let(:body) do
          { forgot_password: {} }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['reset_password_token']).to eq('Reset password token is missing')
          expect(response_body['errors']['password']).to eq('Password is missing')
        end
      end
    end
  end
end
