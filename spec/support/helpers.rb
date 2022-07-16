require 'support/helpers/authorization_helper'
require 'support/helpers/direct_upload_helper'
require 'support/helpers/integration_helper'

RSpec.configure do |config|
  config.include AuthorizationHelper
  config.include DirectUploadHelper
  config.include IntegrationHelper, type: :acceptance
end
