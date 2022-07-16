Dir[Rails.root.join('db/seeds/*.seeds.rb')].each do |file|
  puts "\n🤖 | - Seeding: #{file}"
  require file
end
