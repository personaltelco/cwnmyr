# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do
  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own name
  scenario 'user sees own name' do
    user = FactoryGirl.create(:user, :admin)
    login_as user
    visit users_path
    expect(page).to have_content user.name
  end
end
