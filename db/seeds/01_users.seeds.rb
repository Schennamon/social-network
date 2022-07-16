## === Create User (email: 'user@gmail.com', password: 'Password1') =============
unless Rails.env.production?
  user = User.find_by(email: 'user@gmail.com')
  user = user.presence || FactoryBot.create(:user, email: 'user@gmail.com')

  user.confirm! unless user.confirmed?

  puts "\u{2705} | User created:"
  puts "\u{1F511} | email:    user@gmail.com"
  puts "\u{1F511} | password: Password1"
  puts '🔥 | -'
end
