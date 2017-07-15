feature 'Node network diagram' do
  let(:node) { create :node }

  scenario 'PNG data is returned' do
    visit graph_node_path(node, format: :png)
    expect(page.response_headers['Content-Type']).to eq 'image/png'
  end

  scenario 'other requests are redirected' do
    visit graph_node_path(node)
    expect(current_path).to eq graph_node_path(node, format: :png)
  end
end
