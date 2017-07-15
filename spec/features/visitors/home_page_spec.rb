# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do
  before { visit root_path }

  it { expect(page).to have_content 'Looking for a node?' }
  it { expect(page).to have_selector "#map[data-center='disco']" }
end
