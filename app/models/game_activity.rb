class GameActivity < ApplicationRecord
  belongs_to :killed, class_name: :Player
  belongs_to :killerable, polymorphic: true
  belongs_to :game

  validates :checksum, presence: true, uniqueness: true
end
