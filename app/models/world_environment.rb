class WorldEnvironment < ApplicationRecord
  WORLD_NAME = 'world'.freeze

  has_many :kills, as: :killerable, class_name: :GameActivity
  validates :name, presence: true, uniqueness: true

  def self.instance
    first_or_create(name: WORLD_NAME)
  end
end
