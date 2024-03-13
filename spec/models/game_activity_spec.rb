# spec/models/game_activity_spec.rb
require 'rails_helper'

RSpec.describe GameActivity, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:killed).class_name('Player') }
    it { is_expected.to belong_to(:killerable) }
    it { is_expected.to belong_to(:game) }
  end

  describe "validations" do
    subject { build(:game_activity) }
    it { is_expected.to validate_presence_of(:checksum) }
    it { is_expected.to validate_uniqueness_of(:checksum) }
  end
end