require "spec_helper"

describe "snipp create" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
  end

  before(:each) do
    login_as @user
    visit "/snipps/new"
  end

  it "should show 'You need to sign in or sign up before continuing.' message when trying to create as guest" do
    visit "/users/sign_out"
    visit "/snipps/new"

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  it "should show 'can't be blank' message when trying to create snipp with empty field(s)" do
    click_button "Create Snipp"

    expect(page).to have_content("can't be blank")
  end

  it "should show 'Title is invalid' message when trying to create snipp with invalid title" do
    fill_in "Title",              with: "wrong title1"
    click_button "Create Snipp"

    expect(page).to have_content("Title is invalid")
  end

  it "should show 'Please add some tags' message when trying to create snipp without tags" do
    fill_in "Title",              with: "Good Title"
    fill_in "snipp_html_code",    with: "Good HTML CODE"
    click_button "Create Snipp"

    expect(page).to have_content("Please add some tags")
  end

  it "should show 'Please only add 3 tags' message when trying to create snipp with more then 3 tags" do
    select "blog",                from: "snipp_tag_list"
    select "chat",                from: "snipp_tag_list"
    select "shop",                from: "snipp_tag_list"
    select "menu",                from: "snipp_tag_list"
    click_button "Create Snipp"

    expect(page).to have_content("Please only add 3 tags")
  end

  it "should show 'Snipp was successfully created' message when successfull create snipp" do
    fill_in "Title",              with: "Good Title"
    select "blog",                from: "snipp_tag_list"
    fill_in "snipp_html_code",    with: "Good HTML CODE"
    click_button "Create Snipp"

    expect(page).to have_content("Snipp was successfully created")
  end
end
