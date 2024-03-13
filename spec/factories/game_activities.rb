FactoryBot.define do
  factory :game_activity do
    checksum { "MyString" }
    killed { association(:player) }
    killerable { association(:world_environment) }
    game { association(:game) }
    death_means { GameActivity::DEATH_MEANS.first }
  end
end
