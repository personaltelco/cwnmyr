describe UserPolicy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit nil }
  end

  permissions :show? do
    let(:user) { create :user }

    it { is_expected.to permit nil, user }
  end
end
