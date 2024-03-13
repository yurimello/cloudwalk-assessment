class Game < ApplicationRecord
  belongs_to :game_log
  has_many :activities, class_name: :GameActivity, foreign_key: :game_id
  validates :checksum, presence: true, uniqueness: true
end
