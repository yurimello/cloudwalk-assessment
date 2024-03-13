require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:game_log) }
    it { is_expected.to have_many(:activities).class_name('GameActivity').with_foreign_key(:game_id) }
  end

  describe "validations" do
    subject { build(:game) }
    it { is_expected.to validate_presence_of(:checksum) }
    it { is_expected.to validate_uniqueness_of(:checksum) }
  end
end