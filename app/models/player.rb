class Player < ApplicationRecord
  has_many :deaths, class_name: :GameActivity, foreign_key: :killed_id
  has_many :kills, as: :killerable, class_name: :GameActivity
  validates :name, presence: true, uniqueness: true
end
