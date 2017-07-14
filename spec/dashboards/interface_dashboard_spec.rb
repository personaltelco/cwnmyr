describe InterfaceDashboard do
  subject { InterfaceDashboard }

  let (:interface) { build_stubbed :interface }

  it "defines attribute types" do
    expect(subject.const_get(:ATTRIBUTE_TYPES).length).to eq(28)
  end

  it "defines collection attributes" do
    expect(subject.const_get(:COLLECTION_ATTRIBUTES).length).to eq(5)
  end

  it "defines show page attributes" do
    expect(subject.const_get(:SHOW_PAGE_ATTRIBUTES).length).to eq(28)
  end

  it "defines form attributes" do
    expect(subject.const_get(:FORM_ATTRIBUTES).length).to eq(24)
  end

  it "#display_resource returns a string" do
    expect(subject.new.display_resource(interface)).to match "^Interface ##{interface.to_param}$"
  end
end