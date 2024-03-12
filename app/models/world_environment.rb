class WorldEnvironment < ApplicationRecord
  WORLD_NAME = 'world'.freeze
  validates :name, presence: true, uniqueness: true
  
  def self.instance
    first_or_create(name: WORLD_NAME)
  end
end
