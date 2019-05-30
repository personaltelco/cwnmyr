# frozen_string_literal: true

describe InterfacePropertyPolicy do
  subject { described_class }

  let(:current_user) { build_stubbed :user }
  let(:other_user) { build_stubbed :user }
  let(:admin) { build_stubbed :user, :admin }

  let(:node) { build_stubbed :node, user: current_user }
  let(:device) { build_stubbed :device, node: node }
  let(:interface) { build_stubbed :interface, device: device }
  let(:interface_property) do
    build_stubbed :interface_property, interface: interface
  end

  permissions :show? do
    let(:interface_property) { create :interface_property }

    it { is_expected.to permit nil, interface_property }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit nil, interface_property }
    it { is_expected.not_to permit other_user, interface_property }
    it { is_expected.to permit current_user, interface_property }
    it { is_expected.to permit admin, interface_property }
  end
end
