require "spec_helper"

describe "snipp show" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
    @snipp = Snipp.create(title: Faker::Name.title, html_code:Faker::Lorem.paragraph(5), css_code: "", js_code: "", user_id: @user.id, framework_version: '2.6.3', tag_list: 'blog' )
  end

  before(:each) do
    login_as @user
  end

  it "should show 'Edit' and 'Send to verification' links for owner" do
    visit "/snipps/#{@snipp.id}"
    expect(page).to have_content("Edit")
    expect(page).to have_content("Send to verification")

    click_link "Send to verification"
    expect(page).to have_content("Waiting for verification")
  end

  it "should show 'Snipp not found' if snipp don't exist" do
    visit "/snipps/999999"

    expect(page).to have_content("Snipp not found")
  end
end