include Warden::Test::Helpers
Warden.test_mode!

feature 'Interface Types admin interface', :devise do
  let (:user) { build :user }
  let (:admin) { build :user, :admin }

  after(:each) do
    Warden.test_reset!
  end

  scenario "unauthenticated user attempts access" do
    visit admin_interface_types_path
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content 'You need to sign in'
  end

  scenario "normal user attempts access" do
    login_as user
    visit admin_interface_types_path
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content 'Access denied'
  end

  scenario "admin user attempts access" do
    login_as admin
    visit admin_interface_types_path
    expect(current_path).to eq(admin_interface_types_path)
    expect(page).to have_content 'Interface Types'
  end
end