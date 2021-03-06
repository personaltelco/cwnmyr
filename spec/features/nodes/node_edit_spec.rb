# frozen_string_literal: true

describe 'Node edit page', type: :feature do
  let(:current_user) { create :user }
  let(:node) { create :node, user: current_user }

  before do
    login_as current_user
    visit edit_node_path(node)
  end

  it { expect(page).to have_content 'Edit Node' }

  it 'allows a node to be updated' do
    fill_in 'node_body', with: 'Some text about the node!'
    click_button 'Update'
    expect(page).to have_content 'Some text about the node!'
  end

  it 'shows an error if node update fails' do
    fill_in 'node_name', with: ''
    click_button 'Update'
    expect(page).to have_content "Name can't be blank"
  end
end
