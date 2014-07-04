case Rails.env

when "development"
  puts "********Seeduje Dane na localhost************"
  list_tags = ['user interface', 'admin interface', 'forms', 'buttons', 'table', 'tabs', 'lists', 'modal', 'gallery', 'thumbnails', 'alert', 'registration', 'login', 'menu', 'navbar', 'search', 'footer']

  list_tags.each do |tag|
    ActsAsTaggableOn::Tag.new(name: tag).save
  end

  User.create(nickname: "localAdministrator", password: "password", password_confirmation: "password", email: "user@example.com", admin: true)

  99.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code:Faker::Lorem.paragraph(5), user_id: 1, published: true)
  end

  33.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code:Faker::Lorem.paragraph(5), user_id: 1, to_check: true)
  end

when "production"
  puts "********Seeduje Dane na heroku************"
  list_tags = ['user interface', 'admin interface', 'forms', 'buttons', 'table', 'tabs', 'lists', 'modal', 'gallery', 'thumbnails', 'alert', 'registration', 'login', 'menu', 'navbar', 'search', 'footer']

  list_tags.each do |tag|
    ActsAsTaggableOn::Tag.new(name: tag).save
  end

  99.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code:Faker::Lorem.paragraph(3), user_id: 1, published: true)
  end

  33.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code:Faker::Lorem.paragraph(3), user_id: 1, to_check: true)
  end
end
