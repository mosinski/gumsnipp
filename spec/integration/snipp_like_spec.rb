require "spec_helper"

describe "snipp like" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
    @user2 = User.create(nickname: "user2", email: "user2@example.com", password: "password")
  end

  before(:each) do
    login_as @user2
     @snipp = Snipp.create(title: Faker::Name.title, html_code:Faker::Lorem.paragraph(5), css_code: "", js_code: "", user_id: @user.id, framework_version: '2.6.3', tag_list: 'blog' )
    visit "/snipps/#{@snipp.id}"
  end

  it "should show 'You need to sign in or sign up before continuing.' message when trying to like snipp as guest" do
    visit "/users/sign_out"
    visit "/snipps/#{@snipp.id}/like"

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  it "should show '1 Likes' message when like snipp as login user" do
    visit "/snipps/#{@snipp.id}/like"

    expect(page).to have_content("1 Likes")
  end

  it "should show '0 Likes' message when user press twice like snipp button" do
    page.all(:link,"Likes")[0].click
    page.all(:link,"Likes")[0].click

    expect(page).to have_content("0 Likes")
  end

  it "should show 'Please add some tags' message when trying to create forked snipp without tags" do
    visit "/snipps/#{@snipp.id}/fork"
    fill_in "Title",              with: "Good Title"
    fill_in "snipp_html_code",    with: "Good HTML CODE"
    click_button "Create Snipp"

    expect(page).to have_content("Please add some tags")
  end

  it "should show 'Snipp was successfully created' message when successfull create forked snipp" do
    visit "/snipps/#{@snipp.id}/fork"
    fill_in "Title",              with: "Good Title"
    select "blog",                from: "snipp_tag_list"
    fill_in "snipp_html_code",    with: "Good HTML CODE"
    click_button "Create Snipp"

    expect(page).to have_content("Snipp was successfully created")
  end
end