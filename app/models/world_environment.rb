class WorldEnvironment < ApplicationRecord
  WORLD_NAME = 'world'.freeze
  
  def self.instance
    first_or_create(name: WORLD_NAME)
  end
end
