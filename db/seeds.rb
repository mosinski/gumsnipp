case Rails.env

when "development"
  puts "********Seeduje Dane na localhost************"

  list_tags = ['user interface', 'admin interface', 'forms', 'buttons', 'table', 'tabs', 'lists', 'modal', 'gallery', 'thumbnails', 'alert', 'registration', 'login', 'menu', 'navbar', 'search', 'footer']
  framework_versions = ['2.6.3']

  list_tags.each do |tag|
    ActsAsTaggableOn::Tag.create(name: tag)
  end

  framework_versions.each do |version|
    FrameworkVersion.create(version: version)
  end

  User.create(nickname: "localAdministrator", password: "password", password_confirmation: "password", email: "user@example.com", admin: true)

  99.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code: Faker::Lorem.paragraph(3), css_code: "", js_code: "", user_id: 1, published: true, framework_version: framework_versions.last)
  end

  33.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code:Faker::Lorem.paragraph(3), css_code: "", js_code: "", user_id: 1, to_check: true, framework_version: framework_versions.last)
  end

when "production"
  puts "********Seeduje Dane na heroku************"

  list_tags = ['user interface', 'admin interface', 'forms', 'buttons', 'table', 'tabs', 'lists', 'modal', 'gallery', 'thumbnails', 'alert', 'registration', 'login', 'menu', 'navbar', 'search', 'footer']
  framework_versions = ['2.6.3']

  list_tags.each do |tag|
    ActsAsTaggableOn::Tag.create(name: tag)
  end

  framework_versions.each do |version|
    FrameworkVersion.create(version: version)
  end

  99.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code: Faker::Lorem.paragraph(3), css_code: "", js_code: "", user_id: 1, published: true, framework_version: framework_versions.last)
  end

  33.times do |snipp|
    Snipp.create(title: Faker::Name.name, html_code:Faker::Lorem.paragraph(3), css_code: "", js_code: "", user_id: 1, to_check: true, framework_version: framework_versions.last)
  end
end
