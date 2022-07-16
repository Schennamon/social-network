require 'swagger_helper'

RSpec.describe '/api/v1/user', type: :request do
  let(:password)  { SecureRandom.hex(10) }
  let(:email)     { Faker::Internet.email }
  let(:user)      { create(:user) }
  let(:user2)     { create(:user) }
  let(:new_name)  { Faker::Name.name }

  path '/api/v1/user' do
    post 'Create User' do
      tags 'Users'
      description 'Сreate users with email and password'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        },
        required: %w[user]
      }

      response(200, 'successful') do
        let(:body) do
          { user: { email: email, password: password } }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          response_data = response_body['data']['attributes']
          expect(User.count).to eq(1)
          expect(response_data['email']).to eq(email)
        end
      end

      response(406, 'not_acceptable') do
        let(:body) do
          { user: { email: '', password: '' } }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['email']).to eq('Email must be filled')
          expect(response_body['errors']['password']).to eq('Password must be filled')
        end
      end
    end
  end

  path '/api/v1/user' do
    get 'Get User' do
      tags 'Users'

      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        let(:Authorization) { authorization(user) }
        security [jwt: []]

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['data']['id'].to_i).to eq(user.id)
        end
      end
    end
  end

  path '/api/v1/user' do
    put 'Update User' do
      tags 'Users'

      consumes 'application/json'
      produces 'application/json'

      security [jwt: []]

      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string }
            }
          }
        },
        required: %w[user]
      }

      response(200, 'successful') do
        let(:Authorization) { authorization(user) }

        let(:body) do
          { user: { name: new_name } }
        end

        run_test! do |_response|
          expect(user.reload.name).to eq(new_name)
        end
      end

      response(406, 'not_acceptable') do
        let(:Authorization) { authorization(user) }

        let(:body) do
          { user: { email: user2.email } }
        end

        run_test! do |response|
          response_body = JSON.parse(response.body)
          expect(response_body['errors']['_base']).to eq('You cannot update this data.')
        end
      end
    end

    path '/api/v1/user' do
      delete 'Delete User' do
        tags 'Users'

        consumes 'application/json'
        produces 'application/json'

        response(200, 'success') do
          let(:Authorization) { authorization(user) }
          security [jwt: []]

          run_test! do
            expect(User.find_by(id: user.id)).to be_nil
          end
        end
      end
    end
  end
end
