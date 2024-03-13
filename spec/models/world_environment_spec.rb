require 'rails_helper'

RSpec.describe WorldEnvironment, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:kills) }
  end

  describe "validations" do
    subject { build(:world_environment) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe "class constants" do
    it "has the correct value for WORLD_NAME" do
      expect(WorldEnvironment::WORLD_NAME).to eq('world')
    end
  end

  describe "methods" do
    describe ".instance" do
      it "returns the first instance with name 'world' or creates one" do
        world_env = WorldEnvironment.instance
        expect(world_env.name).to eq('world')
      end
    end
  end
end
