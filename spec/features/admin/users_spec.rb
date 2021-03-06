# frozen_string_literal: true

describe 'Users admin interface', type: :feature do
  let(:user) { build :user }
  let(:admin) { build :user, :admin }

  describe 'unauthenticated user attempts access' do
    before { visit admin_users_path }

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_content 'You need to sign in' }
  end

  describe 'normal user attempts access' do
    before do
      login_as user
      visit admin_users_path
    end

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_content 'Access denied' }
  end

  describe 'admin user attempts access' do
    before do
      login_as admin
      visit admin_users_path
    end

    it { expect(page).to have_current_path(admin_users_path) }
    it { expect(page).to have_content 'Users' }
  end

  describe 'admin user updates a user' do
    let(:user) { create :user }
    let(:admin) { create :user, :admin }

    before do
      login_as admin
      visit edit_admin_user_path(user)
      click_on 'Update User'
    end

    it { expect(page).to have_current_path admin_user_path(user) }
  end
end
