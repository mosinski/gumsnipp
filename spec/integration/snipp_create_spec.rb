require "spec_helper"

describe "snipp create" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
  end

  before(:each) do
    login_as @user
    visit "/snipps/new"
  end

  it "should show 'can't be blank' message when trying to create snipp with empty field(s)" do
    click_button "Create Snipp"

    page.should have_content("can't be blank")
  end
end
