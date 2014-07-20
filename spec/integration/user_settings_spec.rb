require "spec_helper"

describe "user settings" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
  end

  before(:each) do
    login_as @user
    visit "/users/edit"
  end

  it "should show 'You updated your account successfully.' when valid params" do
    fill_in "user_nickname",              with: "Test"
    fill_in "user_current_password",      with: @user.password

    click_button "Update"

    page.should have_content("You updated your account successfully.")
  end

  it "should show 'Current password is invalid' when invalid params" do
    fill_in "user_current_password",      with: "wrongpassword"

    click_button "Update"

    page.should have_content("Current password is invalid")
  end
end
