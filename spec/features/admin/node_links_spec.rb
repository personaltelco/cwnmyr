include Warden::Test::Helpers
Warden.test_mode!

feature 'Node Links admin interface', :devise do
  let (:user) { build :user }
  let (:admin) { build :user, :admin }

  after(:each) do
    Warden.test_reset!
  end

  scenario "unauthenticated user attempts access" do
    visit admin_node_links_path
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content 'You need to sign in'
  end

  scenario "normal user attempts access" do
    login_as user
    visit admin_node_links_path
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content 'Access denied'
  end

  scenario "admin user attempts access" do
    login_as admin
    visit admin_node_links_path
    expect(current_path).to eq(admin_node_links_path)
    expect(page).to have_content 'Links'
  end
end