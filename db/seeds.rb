case Rails.env

when "development"
  puts "********Seeduje Dane na localhost************"
  list_tags = ['user interface', 'admin interface', 'forms', 'buttons', 'table', 'tabs', 'lists', 'modal', 'gallery', 'thumbnails', 'alert', 'registration', 'login', 'menu', 'navbar', 'search', 'footer']

  list_tags.each do |tag|
      ActsAsTaggableOn::Tag.new(:name => tag).save
  end
  User.create(:nickname => "localAdministrator", :password => "password", :password_confirmation => "password", :email => "user@example.com")

when "production"
  puts "********Seeduje Dane na heroku************"
  list_tags = ['user interface', 'admin interface', 'forms', 'buttons', 'table', 'tabs', 'lists', 'modal', 'gallery', 'thumbnails', 'alert', 'registration', 'login', 'menu', 'navbar', 'search', 'footer']

  list_tags.each do |tag|
      ActsAsTaggableOn::Tag.new(:name => tag).save
  end
end
