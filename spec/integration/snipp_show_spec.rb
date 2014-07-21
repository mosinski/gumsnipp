require "spec_helper"

describe "snipp show" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
    login_as @user
    visit "/snipps/new"

    fill_in "Title",              with: "Good Title"
    select "blog",                from: "snipp_tag_list"
    fill_in "snipp_html_code",    with: "Good HTML CODE"
    click_button "Create Snipp"
  end

  it "should show 'Edit' and 'Send to verification' links for owner" do
    page.should have_content("Edit")
    page.should have_content("Send to verification")

    click_link "Send to verification"
    page.should have_content("Waiting for verification")
  end

  it "should show 'Snipp not found' if snipp don't exist" do
    visit "/snipps/1"

    page.should have_content("Snipp not found")
  end
end
