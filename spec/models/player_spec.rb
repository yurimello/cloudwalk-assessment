require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:deaths).class_name('GameActivity').with_foreign_key(:killed_id) }
    it { is_expected.to have_many(:kills) }
  end

  describe "validations" do
    subject { build(:player) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
