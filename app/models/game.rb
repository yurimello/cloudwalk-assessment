class Game < ApplicationRecord
  belongs_to :game_log
  validates :checksum, presence: true, uniqueness: true
end
