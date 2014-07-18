require "spec_helper"

describe "user sign in" do
  before do
    visit "/users/sign_in"
  end

  it "allows users to sign in after they have registered" do
    User.create(nickname: "user", email: "user@example.com", password: "password")

    fill_in "user_login", :with => "user@example.com"
    fill_in "Password", :with => "password"

    click_button "Sign in"

    page.should have_content("Profile")
  end

  it "should show 'Invalid login or password.' when login with invalid params" do
    fill_in 'user_login', with: 'user@example.com'
    fill_in 'Password', with: 'wrongpass'

    click_button "Sign in"

    page.should have_content("Invalid login or password.")
  end
end
