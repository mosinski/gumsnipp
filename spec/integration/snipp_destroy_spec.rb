require "spec_helper"

describe "snipp destroy" do
  before(:all) do
    @user = User.create(nickname: "user", email: "user@example.com", password: "password")
    @snipp = Snipp.create(title: Faker::Name.title, html_code:Faker::Lorem.paragraph(5), css_code: "", js_code: "", user_id: @user.id, framework_version: '2.6.3', tag_list: 'blog' )
  end

  before(:each) do
    login_as @user
    @snipp = Snipp.create(title: Faker::Name.title, html_code:Faker::Lorem.paragraph(5), css_code: "", js_code: "", user_id: @user.id, framework_version: '2.6.3', tag_list: 'blog' )
    visit "/snipps/#{@snipp.id}/edit"
  end

  it "should show 'Destroy' link for owner" do
    expect(page).to have_content("Destroy")
  end
  
  it "should delete snipp from database" do
    expect {
      page.all(:link,"Destroy")[0].click
    }.to change{ Snipp.count }.by(-1)
  end


  it "should show 'Snipp was successfully destroyed.' message when successfull destroy snipp" do
    page.all(:link,"Destroy")[0].click
    expect(page).to have_content("Snipp was successfully destroyed.")
  end
end