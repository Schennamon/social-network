# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           not null
#  name                   :string
#  password_digest        :string           not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class UserSerializer

  include JSONAPI::Serializer

  attributes :email, :name

end
