require "spec_helper"

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit "/users/sign_up"

    fill_in "Email",                 :with => "user@example.com"
    fill_in "Password",              :with => "password"
    fill_in "Password Confirmation", :with => "password"

    click_button "Sign up"

    page.should have_content("user@example.com")
  end
end
