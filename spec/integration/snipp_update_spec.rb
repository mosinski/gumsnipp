require "spec_helper"

describe "snipp update" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
    @snipp = Snipp.create(title: Faker::Name.title, html_code:Faker::Lorem.paragraph(5), css_code: "", js_code: "", user_id: @user.id, published: true, framework_version: '2.6.3', tag_list: 'blog' )
  end

  before(:each) do
    login_as @user
    visit "/snipps/#{@snipp.id}/edit"
  end

  it "should show 'You need to sign in or sign up before continuing.' message when trying to update as guest" do
    visit "/users/sign_out"
    visit "/snipps/#{@snipp.id}/edit"

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
  
  it "should show 'Update Snipp' link for owner" do
    expect(page).to have_content("Update Snipp")
  end

  it "should not change published state when code doesn't change" do
    find('input[value="Update Snipp"]').click

    expect(page).to_not have_content("Send to verification")
  end
end