require "spec_helper"

describe "user registration" do
  before do
    visit "/users/sign_up"
  end

  it "allows new users to register with an nickname, email and password" do
    fill_in "Nickname",              :with => "user"
    fill_in "Email",                 :with => "user@example.com"
    fill_in "Password",              :with => "password"
    fill_in "Password Confirmation", :with => "password"

    click_button "Sign up"

    page.should have_content("Profile")
  end

  it "should show 'Email has already been taken' when submitted with email already in use" do
    User.create(nickname: "taken", email: "taken@example.com", password: "password")

    fill_in "Nickname",              :with => "taken"
    fill_in "Email",                 :with => "taken@example.com"
    fill_in "Password",              :with => "password"
    fill_in "Password Confirmation", :with => "password"

    click_button "Sign up"

    page.should have_content("Email has already been taken")
  end

  it "should show 'can't be blank' message when trying to create user with empty field(s)" do
    click_button "Sign up"

    page.should have_content("can't be blank")
  end
end
