class GameActivity < ApplicationRecord
  belongs_to :killed, class_name: :Player
  belongs_to :killerable, polymorphic: true
  belongs_to :game

  validates :checksum, presence: true, uniqueness: true
  DEATH_MEANS = %w[
    MOD_UNKNOWN
    MOD_SHOTGUN
    MOD_GAUNTLET
    MOD_MACHINEGUN
    MOD_GRENADE
    MOD_GRENADE_SPLASH
    MOD_ROCKET
    MOD_ROCKET_SPLASH
    MOD_PLASMA
    MOD_PLASMA_SPLASH
    MOD_RAILGUN
    MOD_LIGHTNING
    MOD_BFG
    MOD_BFG_SPLASH
    MOD_WATER
    MOD_SLIME
    MOD_LAVA
    MOD_CRUSH
    MOD_TELEFRAG
    MOD_FALLING
    MOD_SUICIDE
    MOD_TARGET_LASER
    MOD_TRIGGER_HURT
    MOD_NAIL
    MOD_CHAINGUN
    MOD_PROXIMITY_MINE
    MOD_KAMIKAZE
    MOD_JUICED
    MOD_GRAPPLE
  ].freeze

  enum :death_means, DEATH_MEANS
end
