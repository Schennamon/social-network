require 'sidekiq/web'

unless Rails.env.development?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username),
                                                Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_USERNAME', nil))) &
      ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password),
                                                  Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_PASSWORD', nil)))
  end
end

Rails.application.routes.draw do
  if Rails.env.development?
    mount Rswag::Api::Engine => '/api-docs'
    mount Rswag::Ui::Engine  => '/api-docs'
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  mount Sidekiq::Web, at: '/admin/sidekiq'

  get '/admin/sidekiq/queue-status' => proc {
                                         [200, { 'Content-Type' => 'text/plain' },
                                          [Sidekiq::Queue.all.sum(&:size) < 100 ? 'OK' : 'UHOH']]
                                       }
  get '/admin/sidekiq/queue-latency' => proc {
                                          [200, { 'Content-Type' => 'text/plain' },
                                           [Sidekiq::Queue.all.map(&:latency).max < 60 ? 'OK' : 'UHOH']]
                                        }

  namespace :api do
    namespace :v1 do
      scope module: :users do
        resource :user, except: %i[edit new index]
      end

      namespace :users do
        resource :email_confirmation, only: :create
        resource :authentication, only: :create
        resource :forgot_password, only: %i[create update]
      end
    end
  end
end
